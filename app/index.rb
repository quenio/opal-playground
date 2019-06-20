# frozen_string_literal: true

require 'space'
require 'sheet'
require 'palette'
require 'inspector'
require 'view_spec'
require 'input'

items = [
  ViewSpec.new(
    caption: 'Input',
    class_name: Input.to_s,
    fixed_style_classes: %w[w-25]
  )
]

$doc.addEventListener 'DOMContentLoaded' do
  Space.find($doc.body)
  Palette.find($doc.body).refresh(items)
end

