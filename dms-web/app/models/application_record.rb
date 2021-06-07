# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include CurrentUser

  self.abstract_class = true
end
