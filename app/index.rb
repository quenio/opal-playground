# frozen_string_literal: true

require 'space'
require 'sheet'
require 'palette'
require 'view_spec'

def start
  Sheet.new
  items = [
    ViewSpec.new(
      caption: 'Hello',
      class_name: View.to_s,
      text: 'Hello, world!'
    )
  ]
  with Palette.new(items: items) do
    style.width = '15em'
    style.height = '10em'
    self.docking_side = :right
  end
end
