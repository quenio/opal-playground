# frozen_string_literal: true

#--
# Copyright (c) 2019 Quenio Cesar Machado dos Santos
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
# NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++
#

require 'view'

class Tool < View
  def initialize(params = {})
    super(params.merge(classes: %w[border ml-auto]))
    @style.width = '10em'
    @style.height = '10em'
    init_resizing_width
  end

  private

  def init_resizing_width
    on :mousedown, &method(:start_resizing_width)
    on :mouseup, &method(:stop_resizing_width)
    on :mousemove, &method(:check_resizing_width)
    on :mouseout, &method(:check_resizing_width)
  end

  def start_resizing_width
    $space.start_resizing_width(self) if @width_anchored
  end

  def stop_resizing_width
    $space.stop_resizing_width(self) if @width_anchored
  end

  def check_resizing_width(event)
    rect = event.target.getBoundingClientRect
    x = event.clientX - rect.left
    @width_anchored = x.between? 0, 2
    @style.cursor = @width_anchored ? 'col-resize' : nil
  end
end