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
require 'resizable'

class Tool < View
  include Resizable

  def initialize(params = {})
    super(params)

    @style.width = '10em'
    @style.height = '10em'
    @style.backgroundColor = 'red'

    self.docking_side = params[:docking_side] || :left

    support_resizing
  end

  def docking_side=(value)
    @docking_side = value
    self.style_classes =
      if @docking_side == :left
        %w[border ml-auto h-100]
      elsif @docking_side == :right
        %w[border mr-auto h-100]
      elsif @docking_side == :top
        %w[border mb-auto w-100]
      elsif @docking_side == :bottom
        %w[border mt-auto w-100]
      end
  end
end