# == Schema Information
#
# Table name: announcements
#
#  id          :integer          not null, primary key
#  headline    :string(255)
#  description :text
#  posted_by   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

describe Announcement do
  it 'should have a valid factory' do
    announcement = build(:announcement)
    expect(announcement).to be_valid
  end

  describe '.last_7_days' do
    it 'returns announcements created in the last 7 days' do
      announcement = create(:announcement)
      expected = [announcement]
      result = Announcement.last_7_days
      expect(expected).to eq(result)
    end

    it 'does not return announcements older than 7 days' do
      eight_days_ago = Time.zone.now - 8.days
      announcement = create(:announcement, created_at: eight_days_ago)
      expected = []
      result = Announcement.last_7_days
      expect(expected).to eq(result)
    end
  end
end
