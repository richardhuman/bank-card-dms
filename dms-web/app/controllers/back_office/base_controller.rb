# frozen_string_literal: true

module BackOffice
  class BaseController < ApplicationController
    def sub_layout
      "back_office"
    end
  end
end
