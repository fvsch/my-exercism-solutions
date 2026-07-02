defmodule PaintByNumber do
  def palette_bit_size(color_count, size \\ 0) do
    if color_count > 2 ** size do
      palette_bit_size(color_count, size + 1)
    else
      size
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    ps = palette_bit_size(color_count)
    <<pixel_color_index::size(ps), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil

  def get_first_pixel(picture, color_count) do
    ps = palette_bit_size(color_count)
    <<first::size(ps), _::bitstring>> = picture
    first
  end

  def drop_first_pixel(<<>>, _), do: <<>>

  def drop_first_pixel(picture, color_count) do
    ps = palette_bit_size(color_count)
    <<_::size(ps), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
