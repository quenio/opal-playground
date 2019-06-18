# frozen_string_literal: true

require 'space'
require 'palette'
require 'object_spec'

def start
  items = [
    ObjectSpec.new(
      caption: 'Hello',
      class_name: View.to_s,
      text: 'Hello, world!'
    )
  ]
  with Palette.new(items: items) do
    style.width = '10em'
    style.height = '10em'
    self.docking_side = :right
  end
end
