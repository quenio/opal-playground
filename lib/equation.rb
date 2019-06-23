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

require 'watcher'

class Equation
  include Watcher

  OPERATOR = '='

  def self.parse(line)
    left, right = line.split(OPERATOR).map(&:strip)
    return nil unless left and right
    return nil if left.strip.empty?
    return nil if right.strip.empty?

    left_var = $model.find_or_create_variable(left)
    right_var = $model.find_or_create_variable(right)
    new(left: left_var, right: right_var)
  end

  attr_reader :left, :right

  def initialize(left:, right:)
    @left = left
    @right = right

    start_observing_terms
  end

  def ==(other)
    @left == other.left and @right == other.right
  end

  def on_update(source)
    target = if source == @left
               @right
             elsif source == @right
               @left
             end

    return unless target

    target.value = source.value
  end

  def stop_observing_terms
    @left.delete_observer self
    @right.delete_observer self
  end

  private

  def start_observing_terms
    @left.add_observer self
    @right.add_observer self
  end
end