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
require 'input'

class Inspector < Tool
  def initialize(params = {})
    super(params.merge(title: 'Inspector'))
  end

  def display(view)
    return if view.parent == @attribute_list

    @attribute_list.parent = nil if @attribute_list
    @attribute_list = List.new(
      parent: self,
      flush: true,
      fixed_style_classes: %w[mt-1],
      item_view: method(:item_view),
      items: view.attributes
    )
  end

  private

  def item_view(item)
    input = Input.new(
      placeholder: item.name.chop,
      non_selectable: true,
      fixed_style_classes: %w[w-auto]
    )
    input.on 'input' do |event|
      item.call(event.target.value)
    end
    input
  end
end