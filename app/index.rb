# frozen_string_literal: true

require 'space'
require 'palette'

def start
  items = [
    View.new(text: 'Hello, World!', caption: 'Hello')
  ]
  with Palette.new(items: items) do
    style.width = '10em'
    style.height = '10em'
    self.docking_side = :right
  end
end
