# frozen_string_literal: true

require 'blocks'

$doc = $$.document

$view_cache = {}

class View

  def self.find(root)
    data_view = root.getAttribute('data-view')
    return create_or_find(root) if data_view == name

    Array(root.children).each do |element|
      view = find(element)
      return view if view
    end

    nil
  end

  def self.create_or_find(element)
    $view_cache[element] ||= create(element)
  end

  def self.create(element, parent = nil)
    $view_cache[element] = new(data_attributes(element).merge(element: element, parent: parent))
  end

  def self.data_attributes(element)
    Array(element.attributes)
      .select { |a| a.name.start_with? 'data-' }
      .reject { |a| a.name == 'data-view' }
      .map { |a| [a.name[5..-1].tr('-', '_'), a.value] }
      .to_h
  end

  attr_reader :parent
  attr_reader :caption

  def initialize(params = {})
    @element = params[:element]
    @element ||= $doc.getElementById(params[:id]) if params[:id]
    @element ||= $doc.createElement(params[:tag] || 'div')

    raise "Element not found for params: #{params.inspect}" unless @element

    @element.setAttribute 'data-view', self.class.name

    @style = @element.style
    @fixed_style_classes = params[:fixed_style_classes] || []
    @caption = params[:caption] || self.class.to_s

    self.style_classes = params[:style_classes] || []
    self.text = params[:text] if params[:text]
    self.parent = params[:parent] if params[:parent]

    create_subviews(@element.children)
  end

  def parent=(view)
    return if view == @parent

    previous_parent = @parent
    @parent = view
    return unless @parent
    return if find_element(@parent.element, @element)

    previous_parent&.removeChild @element
    @parent.element.appendChild @element
  end

  def text
    @element.innerHTML.to_s
  end

  def text=(value)
    @element.innerHTML = value.to_s
  end

  def on(event_type)
    @element.addEventListener event_type do |event|
      yield Native::Object.new(event), self
    end
  end

  def clear
    @element.removeChild @element.firstChild while @element.firstChild
  end

  private

  def find_element(root, element)
    Array(root.children).each do |child|
      return true if child == element || find_element(child, element)
    end
    false
  end

  def create_subviews(children)
    Array(children).each do |element|
      data_view = element.getAttribute('data-view')
      if data_view
        Object.const_get(data_view).create(element, self)
      else
        create_subviews(element.children)
      end
    end
  end

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

