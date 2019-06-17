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

module Resizer

  def start_resizing(view, side)
    @resizing_view = view
    @resizing_side = side
  end

  def stop_resizing(view)
    @resizing_view = nil if @resizing_view == view
  end

  private

  def support_resizing
    on :mousemove, &method(:resize_view)
    on :mouseup do
      stop_resizing @resizing_view if @resizing_view
    end
  end

  def resize_view(event)
    return unless @resizing_view

    rect = @resizing_view.element.getBoundingClientRect

    case @resizing_side
    when :left
      width = rect.width - (event.clientX - rect.left)
      @resizing_view.style.width = width.to_s + 'px'
    when :bottom
      height = rect.height - (rect.bottom - event.clientY)
      @resizing_view.style.height = height.to_s + 'px'
    else
      raise 'Resizing direction not specified.'
    end

    @resizing_view.style.cursor = 'col-resize'
  end

end