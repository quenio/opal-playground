# frozen_string_literal: true

require 'space'
require 'sheet'
require 'palette'
require 'inspector'
require 'view_spec'
require 'field'

items = [
  ViewSpec.new(
    caption: 'Field',
    class_name: Field.to_s,
    fixed_style_classes: %w[w-25]
  )
]

$doc.addEventListener 'DOMContentLoaded' do
  Space.find($doc.body)
  Palette.find($doc.body).refresh(items)
end

