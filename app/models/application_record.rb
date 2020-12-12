class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end


Decidim::User.class_exec do
  validates :pesel, presence: true, length: { is: 11 }
  validate :validate_pesel

  def validate_pesel
    return if pesel.blank?
    errors.add(:pesel, :invalid) unless Pesel.new(pesel).valid?
  end
end


Decidim::CreateRegistration.class_exec do
  def create_user
    @user = Decidim::User.create!(email: form.email,
                                  name: form.name,
                                  pesel: form.pesel,
                                  nickname: form.nickname,
                                  password: form.password,
                                  password_confirmation: form.password_confirmation,
                                  organization: form.current_organization,
                                  tos_agreement: form.tos_agreement,
                                  newsletter_notifications_at: form.newsletter_at,
                                  email_on_notification: true,
                                  accepted_tos_version: form.current_organization.tos_version)
  end
end
