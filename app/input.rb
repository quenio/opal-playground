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

class Input < View
  include Selectable

  attr_reader :placeholder, :variable

  def initialize(params = {})
    super(params.merge(
      tag: 'input',
      fixed_style_classes: %w[form-control m-1 mb-2] + (params[:fixed_style_classes] || [])
    ))
    self.placeholder = params[:placeholder]
    self.variable = params[:variable]
    support_selection unless params[:non_selectable]
  end

  def properties
    [method('variable='.to_sym)]
  end

  def placeholder=(value)
    @placeholder = value
    @element.setAttribute :placeholder, @placeholder if @placeholder
  end

  def variable=(value)
    @variable = value
    @element.setAttribute :placeholder, @variable || '' unless @placeholder
  end
end