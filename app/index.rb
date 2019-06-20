# frozen_string_literal: true

require 'space'
require 'sheet'
require 'palette'
require 'inspector'
require 'view_spec'
require 'input'

$doc.addEventListener 'DOMContentLoaded' do
  Space.find($doc.body)
end

# def start
  # items = [
  #   ViewSpec.new(
  #     caption: 'Input',
  #     class_name: Input.to_s,
  #     fixed_style_classes: %w[w-25]
  #   )
  # ]
  # with Palette.new(items: items) do
  #   style.width = '15em'
  #   self.docking_side = :left
  # end
# end
