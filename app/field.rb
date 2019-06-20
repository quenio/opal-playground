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

class Field < View
  include Selectable

  attr_reader :label, :variable

  def initialize(params = {})
    super(params.merge(
      fixed_style_classes: %w[m-1 mb-2] + (params[:fixed_style_classes] || [])
    ))

    @span = View.new(parent: self, tag: 'span')
    @input = View.new(
      parent: self, tag: 'input',
      fixed_style_classes: %w[form-control]
    )

    self.variable = params[:variable]
    self.label = params[:label] || variable || 'Field'

    support_selection unless params[:non_selectable]
  end

  def properties
    %w[label variable].map do |item|
      method("#{item}=".to_sym)
    end
  end

  def label=(value)
    @label = value
    @span.text = @label if @label
  end

  def variable=(value)
    @variable = value
    @span.text = @variable || '' unless @label
  end
end