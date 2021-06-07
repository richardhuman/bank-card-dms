# frozen_string_literal: true

class UserSession
  include ActiveModel::Model
  attr_accessor :username, :password

  validates :username, presence: true
  validates :password, presence: true

  def login
    login = User.find_by(mobile_number: self.username)
    if login.nil?
      login = User.find_by(email: self.username)
    end

    if login.nil?
      errors.add(:base, I18n.t("errors.login.failed"))
      return nil
    end

    unless login.active?
      errors.add(:base, I18n.t("errors.login.not_active"))
      return nil
    end

    unless login.authenticate(self.password)
      errors.add(:base, I18n.t("errors.login.failed"))
      return nil
    end

    login
  end
end
