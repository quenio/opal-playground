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

class Space < View
  def initialize(params = {})
    super(params.merge(element: $doc.body, classes: 'd-flex'))
    on :mousemove, &method(:resize_width)
  end

  def start_resizing_width(view)
    @resizing_view = view
  end

  def stop_resizing_width(view)
    @resizing_view = nil if @resizing_view == view
  end

  private

  def resize_width(event)
    return unless @resizing_view

    rect = @resizing_view.element.getBoundingClientRect
    x = event.clientX - rect.left
    @resizing_view.style.width = (rect.width - x).to_s + 'px'
    @resizing_view.style.cursor = 'col-resize'
  end
end

$doc.addEventListener 'DOMContentLoaded' do
  $space = Space.new
  start
end
