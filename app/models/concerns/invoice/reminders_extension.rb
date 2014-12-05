module Invoice::RemindersExtension
  extend ActiveSupport::Concern

  included do
    before_save :calculate_dates, if: :due_date_changed?
    before_save :set_final_demand, if: :status_id_changed?
  end

  def pre_due?
    pd_date == DateTime.now.to_date
  end

  def due?
    due_date == DateTime.now.to_date
  end

  def over_due1?
    od1_date == DateTime.now.to_date
  end

  def over_due2?
    od2_date == DateTime.now.to_date
  end

  def over_due3?
    od3_date == DateTime.now.to_date
  end

  def final_demand?
    fd_date == DateTime.now.to_date
  end

  protected

  def calculate_dates
    self.pd_date = due_date.days_ago(user.setting.days_before_pre_due)
    self.od1_date = due_date.days_since(user.setting.days_between_chase)
    self.od2_date = due_date.days_since(user.setting.days_between_chase * 2)
    self.od3_date = due_date.days_since(user.setting.days_between_chase * 3)
  end

  def set_final_demand
    self.fd_date = Date.today.days_since(1) if send_final_demand?
  end

end