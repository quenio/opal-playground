# frozen_string_literal: true

require 'space'
require 'sheet'
require 'palette'
require 'inspector'
require 'view_spec'
require 'input'

def start
  items = [
    ViewSpec.new(
      caption: 'Input',
      class_name: Input.to_s
    )
  ]
  with Palette.new(items: items) do
    style.width = '15em'
    self.docking_side = :left
  end
  Sheet.new
  with Inspector.new(docking_side: :right) do
    style.width = '15em'
  end
end
