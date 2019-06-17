require 'opal'
require 'native'

@doc = $$.document

@doc.addEventListener 'DOMContentLoaded' do
  start
end

def on(element_id, event_type)
  @doc.getElementById(element_id)
      .addEventListener event_type do
    yield
  end
end

def element(element_name)
  element = @doc.createElement(element_name)
  element.innerHTML = yield
  @doc.body.appendChild(element)
end

def span(&block)
  element 'span', &block
end
