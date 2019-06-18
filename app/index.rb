# frozen_string_literal: true

require 'space'
require 'palette'

def start
  with Palette.new(items: ["One", "Two", "Three"]) do
    style.width = '10em'
    style.height = '10em'
    self.docking_side = :right
  end
end
