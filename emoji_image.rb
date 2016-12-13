require 'RMagick'
require 'pry'
include Magick

class EmojiImage
  attr_reader :path

  def initialize(text)
    f = Magick::Image.new(64, 64) do
      self.background_color= "Transparent"
    end

    d = Magick::Draw.new

    padding = 4
    fontsize =  (64 - padding * 2) / 2

    text.split('').to_a.each_slice((text.size / 2).round).with_index do |row, index|
      p index
      row_text = row.join

      d.annotate(f, 0, 0, padding, padding + index * fontsize, row_text) do
        self.pointsize = fontsize
        self.fill = 'orange'
        self.font = 'NotoSansCJKjp-Medium.otf'
        self.gravity = Magick::NorthGravity
      end
    end

    @path = "public/dest-#{SecureRandom.base64}.png"
    f.write(@path)
  end
end

text = ARGV[0]
unless text
  puts 'Require args: image path'
  exit
end

image = EmojiImage.new(text)
`open #{image.path}`
