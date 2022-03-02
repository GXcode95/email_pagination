class Email < ApplicationRecord

  validates :sender, presence: true, format: { 
                                      with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
                                      message: "email adress please" }
  validates :recipient, presence: true, format: {
                                          with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
                                          message: "email adress please" }
  validates :content, presence: true
  validates :object, presence: true, length: { maximum: 90 }

  scope :sended, ->(user_email) { order(created_at: :desc).where("sender = ?", user_email) }
  scope :received, ->(user_email) { order(created_at: :desc).where("recipient = ?", user_email) }

  SECONDS_IN_ONE_DAY = 86400

  def date
    Time.now - created_at > SECONDS_IN_ONE_DAY ?
      "#{created_at.day} #{I18n.t('date.abbr_month_names')[created_at.month]}" :
      "#{created_at.hour}:#{created_at.min}"
  end

  def full_date
    "#{created_at.day} #{I18n.t('date.month_names')[created_at.month]} #{created_at.year} à #{created_at.hour}H#{created_at.min}" 
  end

  def is_author?(user)
    sender == user.email
  end

  def self.unread_count(user)
    Email.where(recipient: user.email).where(read: false).size
  end

end
