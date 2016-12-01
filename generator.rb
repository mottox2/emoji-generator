require 'RMagick'
include Magick

f = Magick::Image.new(512, 512) do
  self.background_color = 'white'
end

d = Magick::Draw.new

padding = 30
text = 'テキスト'
fontsize = (512 - padding * 2) / text.size
d.annotate(f, 0, 0, padding, padding, 'テキスト') do
  self.pointsize = fontsize
  self.font = 'NotoSansCJKjp-Medium.otf'
  self.gravity = Magick::NorthWestGravity
end

f.write('dest.png')

`open dest.png`
