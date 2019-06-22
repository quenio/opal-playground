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


module Resizable
  private

  def support_resizing
    on :mousedown, &method(:start_resizing)
    on :mouseup, &method(:stop_resizing)
    on :mousemove, &method(:check_resizing)
    on :mouseout, &method(:check_resizing)
  end

  def start_resizing
    @parent.start_resizing(self, @resizing_side) if @resizing_side
  end

  def stop_resizing
    @parent.stop_resizing(self)
  end

  def check_resizing(event)
    rect = event.target.getBoundingClientRect

    left_delta = event.clientX - rect.left
    right_delta = event.clientX - rect.right
    bottom_delta = event.clientY - rect.bottom
    top_delta = event.clientY - rect.top

    @resizing_side =
      if left_delta.between?(0, 2)
        :left
      elsif right_delta.between?(-2, 0)
        :right
      elsif bottom_delta.between?(-2, 0)
        :bottom
      elsif top_delta.between?(0, 2)
        :top
      end

    @style.cursor =
      if %i[left right].include?(@resizing_side)
        'col-resize'
      elsif %i[top bottom].include?(@resizing_side)
        'row-resize'
      end
  end
end