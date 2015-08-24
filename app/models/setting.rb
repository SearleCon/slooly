# == Schema Information
#
# Table name: settings
#
#  id                     :integer          not null, primary key
#  send_from_name         :string(255)
#  email_copy_to          :string(255)
#  days_between_chase     :integer
#  days_before_pre_due    :integer
#  payment_method_message :text
#  pre_due_reminder       :boolean
#  pre_due_subject        :string(255)
#  pre_due_message        :text
#  due_reminder           :boolean
#  due_subject            :string(255)
#  due_message            :text
#  overdue1_subject       :string(255)
#  overdue1_message       :text
#  overdue2_subject       :string(255)
#  overdue2_message       :text
#  overdue3_subject       :string(255)
#  overdue3_message       :text
#  final_demand_subject   :string(255)
#  final_demand_message   :text
#  user_id                :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class Setting < ActiveRecord::Base
  belongs_to :user, touch: true

  validates :days_between_chase, :days_before_pre_due, presence: true
  validates :days_between_chase, inclusion: { in: 1..31, message: 'can only be between 0 and 31.' }
  validates :days_before_pre_due, inclusion: { in: 1..31, message: 'can only be between 0 and 31.' }

  after_initialize :set_defaults, if: :new_record?

  def payment_method_message=(value)
    value = value.strip.squeeze(' ') if value
    super(value)
  end

  def pre_due_message=(value)
    value = value.strip.squeeze(' ') if value
    super(value)
  end

  def due_message=(value)
    value = value.strip.squeeze(' ') if value
    super(value)
  end

  def overdue1_message=(value)
    value = value.strip.squeeze(' ') if value
    super(value)
  end

  def overdue2_message=(value)
    value = value.strip.squeeze(' ') if value
    super(value)
  end

  def overdue3_message=(value)
    value = value.strip.squeeze(' ') if value
    super(value)
  end

  def final_demand_message=(value)
    value = value.strip.squeeze(' ') if value
    super(value)
  end

  protected

  def set_defaults
    self.send_from_name = 'Your Business'
    self.email_copy_to = 'copy@example.com'
    self.days_between_chase = 7
    self.days_before_pre_due = 2
    self.payment_method_message = I18n.t('defaults.settings.payment_method_message')
    self.pre_due_reminder = true
    self.pre_due_subject = 'Friendly Reminder: Payment due soon'
    self.pre_due_message = I18n.t('defaults.settings.pre_due_message')

    self.due_reminder = true
    self.due_subject = 'Payment Due Today'
    self.due_message = I18n.t('defaults.settings.due_message')

    self.overdue1_subject = 'Important Reminder: Payment overdue'
    self.overdue1_message = I18n.t('defaults.settings.overdue1_message')

    self.overdue2_subject = 'Second Reminder - Important: Payment is overdue'
    self.overdue2_message = I18n.t('defaults.settings.overdue2_message')

    self.overdue3_subject = 'URGENT: Third and Final Reminder: Payment is now way overdue!'
    self.overdue3_message = I18n.t('defaults.settings.overdue3_message')

    self.final_demand_subject = 'Notice of Final Demand: Action Required'
    self.final_demand_message = I18n.t('defaults.settings.final_demand_message')
  end
end
