# frozen_string_literal: true

require 'opal'
require 'native'
require 'jquery-3.4.1.min'
require 'popper'
require 'bootstrap-sprockets'

$doc = $$.document

class View

  attr_reader :element, :style, :parent

  def initialize(params = {})
    @element = params[:element]
    @element ||= $doc.getElementById(params[:id]) if params[:id]
    @element ||= $doc.createElement(params[:tag] || 'div')

    @style = @element.style

    @element.classList.add(*params[:classes]) if params[:classes]

    self.parent = params[:parent] || $doc_view if @element != $doc.body
  end

  def parent=(view)
    @parent&.removeChild @element
    @parent = view
    @parent.element.appendChild @element
  end

  def on(event_type)
    @element.addEventListener event_type do |event|
      yield Native::Object.new(event)
    end
  end
end

$doc.addEventListener 'DOMContentLoaded' do
  $doc_view ||= View.new(element: $doc.body, classes: 'd-flex')
  start
end

