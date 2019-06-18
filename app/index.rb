# frozen_string_literal: true

require 'space'
require 'sheet'
require 'palette'
require 'view_spec'
require 'input'

def start
  Sheet.new
  items = [
    ViewSpec.new(
      caption: 'Input',
      class_name: Input.to_s
    )
  ]
  with Palette.new(items: items) do
    style.width = '15em'
    style.height = '10em'
    self.docking_side = :right
  end
end
