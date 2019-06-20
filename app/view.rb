# frozen_string_literal: true

require 'blocks'
require 'jquery-3.4.1.min'
require 'popper'
require 'bootstrap-sprockets'

$doc = $$.document

class View

  def self.find(root)
    data_view = root.getAttribute('data-view')
    print data_view, "\n"
    return Object.const_get(name).new(element: root) if data_view == name

    Array(root.children).each do |element|
      view = find(element)
      return view if view
    end

    nil
  end

  attr_reader :parent
  attr_reader :caption

  def initialize(params = {})
    @element = params[:element]
    @element ||= $doc.getElementById(params[:id]) if params[:id]
    @element ||= $doc.createElement(params[:tag] || 'div')

    raise "Element not found for params: #{params.inspect}" unless @element

    @style = @element.style
    @fixed_style_classes = params[:fixed_style_classes] || []
    @caption = params[:caption] || self.class.to_s

    self.style_classes = params[:style_classes] || []
    self.text = params[:text] if params[:text]
    self.parent = params[:parent] || $space if @element != $doc.body
  end

  def parent=(view)
    @parent&.element&.removeChild @element
    @parent = view
    @parent&.element&.appendChild @element
  end

  def text=(value)
    @element.innerHTML = value
  end

  def on(event_type)
    @element.addEventListener event_type do |event|
      yield Native::Object.new(event), self
    end
  end

  private

  attr_reader :element, :style
  attr_reader :fixed_style_classes

  def style_classes=(classes)
    list = @element.classList
    list.remove list.item(0) while list.length > 0
    list.add(*fixed_style_classes) unless fixed_style_classes&.empty?
    list.add(*classes)
  end

  def add_style_class(style_class)
    @element.classList.add style_class
  end

  def remove_style_class(style_class)
    @element.classList.remove style_class
  end
end

