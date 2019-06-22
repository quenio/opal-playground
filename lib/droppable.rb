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

require 'view_spec'
require 'json'

module Droppable
  def support_dropping
    on 'dragover', &method(:drag_over)
    on 'dragenter', &method(:drag_enter)
    on 'dragleave', &method(:drag_leave)
    on 'drop', &method(:drop)
  end

  def drag_over(event)
    event.preventDefault
  end

  def drag_enter(_event, view)
    view.add_style_class 'bg-light'
  end

  def drag_leave(_event, view)
    view.remove_style_class 'bg-light'
  end

  def drop(event, view)
    event.preventDefault
    view_spec = event.dataTransfer.getData("view_spec")
    ViewSpec.new(JSON.parse(view_spec)).create_view(parent: view)
    view.remove_style_class 'bg-light'
  end
end