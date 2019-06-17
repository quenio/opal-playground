# frozen_string_literal: true

require 'tool'

def start
  View.new(id: 'btn-add').on 'click' do
    view = Tool.new
    view.style.height = '5em'
  end
end
