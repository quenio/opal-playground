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

require 'tool'
require 'list'
require 'draggable'

class Palette < Tool
  def initialize(params = {})
    super(params.merge(title: 'Palette'))

    @list = List.new(
      parent: self,
      flush: true,
      fixed_style_classes: %w[mt-1],
      item_view: method(:item_view),
      items: params[:items] || []
    )
  end

  def refresh(items)
    @list.refresh(items)
  end

  private

  class ItemView < View
    include Draggable

    def initialize(item)
      super(fixed_style_classes: %w[border border-light rounded bg-light text-center m-1 p-1])
      @item = item
      self.text = caption
      support_dragging
    end

    def caption
      @item.respond_to?(:caption) ? @item.caption : @item.class.to_s
    end

    def spec
      @item.is_a?(ViewSpec) ? @item.to_h : @item.to_s
    end
  end

  def item_view(item)
    ItemView.new(item)
  end
end