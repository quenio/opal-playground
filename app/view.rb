# frozen_string_literal: true

require 'opal'
require 'native'

$doc = $$.document

class View

  attr_reader :element, :style, :parent

  def initialize(params = {})
    @element = params[:element]
    @element ||= $doc.getElementById(params[:id]) if params[:id]
    @element ||= $doc.createElement(params[:tag] || 'div')

    @style = @element.style

    self.parent = params[:parent] || $doc_view if @element != $doc.body
  end

  def parent=(view)
    @parent&.removeChild @element
    @parent = view
    @parent.element.appendChild @element
  end

  def on(event_type)
    @element.addEventListener event_type do
      yield self
    end
  end
end

$doc.addEventListener 'DOMContentLoaded' do
  $doc_view ||= View.new(element: $doc.body)
  start
end

