# frozen_string_literal: true

require 'space'
require 'tool'

def start
  with Tool.new do
    style.width = '10em'
    style.height = '10em'
    docking_side = :right
  end
end
