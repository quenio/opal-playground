# frozen_string_literal: true

require 'blocks'
require 'jquery-3.4.1.min'
require 'popper'
require 'bootstrap-sprockets'

$doc = $$.document

class View

  attr_reader :element, :style, :parent
  attr_reader :fixed_style_classes

  def initialize(params = {})
    @element = params[:element]
    @element ||= $doc.getElementById(params[:id]) if params[:id]
    @element ||= $doc.createElement(params[:tag] || 'div')

    @style = @element.style
    @fixed_style_classes = params[:fixed_style_classes] || []

    self.style_classes = params[:style_classes] || []
    self.parent = params[:parent] || $space if @element != $doc.body
  end

  def parent=(view)
    @parent&.removeChild @element
    @parent = view
    @parent.element.appendChild @element
  end

  def text=(value)
    @element.innerHTML = value
  end

  def style_classes=(classes)
    list = @element.classList
    list.remove list.item(0) while list.length > 0
    list.add(*fixed_style_classes) unless fixed_style_classes&.empty?
    list.add(*classes)
  end

  def on(event_type)
    @element.addEventListener event_type do |event|
      yield Native::Object.new(event)
    end
  end
end

