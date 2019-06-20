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
require 'selectable'
require 'property'
require 'bindable'

class Field < View
  include Selectable
  include Bindable

  attr_reader :label

  def initialize(params = {})
    super(params.merge(
      fixed_style_classes: %w[m-1 mb-2] + (params[:fixed_style_classes] || [])
    ))

    @span = View.new(parent: self, tag: 'span')
    @input = View.new(
      parent: self,
      tag: 'input',
      fixed_style_classes: %w[form-control]
    )

    self.label = params[:label] || 'Field'
    self.value = params[:value] if params[:value]

    support_selection unless params[:non_selectable]
  end

  def properties
    Property.list(self, %i[label variable])
  end

  def label=(value)
    @label = value
    @span.text = @label if @label
  end

  def value=(value)
    @input.element.value = value
  end
end