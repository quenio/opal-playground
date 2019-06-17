# frozen_string_literal: true

require 'view'

def start
  View.new(id: 'btn-add').on 'click' do
    view = View.new
    view.style.backgroundColor = 'red'
    view.style.height = '500em'
  end
end
