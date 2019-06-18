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

class List < View
  def initialize(params = {})
    super(params.merge(
      tag: 'ul',
      fixed_style_classes: %w[list-group] + (params[:fixed_style_classes] || [])
    ))

    self.flush = params[:flush] || false

    @item_view = params[:item_view] || method(:item_view)

    params[:items].each do |item|
      item_view = View.new(parent: self, tag: 'li', fixed_style_classes: 'list-group-item')
      item_view.text = @item_view.call(item)
    end
  end

  def item_view(item)
    item.to_s
  end

  def flush=(value)
    self.style_classes = value ? %w[list-group-flush] : []
  end
end