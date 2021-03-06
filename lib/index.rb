# frozen_string_literal: true

require 'opal'
require 'native'

require 'jquery-3.4.1.min'
require 'popper'
require 'bootstrap-sprockets'

require 'space'
require 'sheet'
require 'palette'
require 'inspector'
require 'view_spec'
require 'field'
require 'text'
require 'constraint_editor'

items = [
  ViewSpec.new(
    caption: 'Field',
    class_name: Field.to_s,
    fixed_style_classes: %w[w-25]
  ),
  ViewSpec.new(
    caption: 'Text',
    class_name: Text.to_s,
    text: 'Text',
    fixed_style_classes: %w[w-25]
  )
]

$doc.addEventListener 'DOMContentLoaded' do
  Space.find($doc.body)
  Palette.find($doc.body).refresh(items)
end

