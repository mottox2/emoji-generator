require 'RMagick'
include Magick

class EmojiImage
  attr_reader :path

  def initialize(text)
    f = Magick::Image.new(512, 512) do
      self.background_color = 'white'
    end

    d = Magick::Draw.new

    padding = 30
    fontsize =  (512 - padding * 2) / 2

    text.split('').to_a.each_slice((text.size / 2).to_i).with_index do |row, index|
      p index
      row_text = row.join

      d.annotate(f, 0, 0, padding, padding + index * fontsize, row_text) do
        self.pointsize = fontsize
        self.fill = 'orange'
        self.font = 'NotoSansCJKjp-Medium.otf'
        self.gravity = Magick::NorthWestGravity
      end
    end


    @path = "public/dest-#{SecureRandom.base64}.png"
    f.write(@path)
  end
end

# `open dest.png`
