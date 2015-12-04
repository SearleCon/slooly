# == Schema Information
#
# Table name: announcements
#
#  id          :integer          not null, primary key
#  headline    :string(255)
#  description :text
#  posted_by   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

describe Announcement do
  describe '.recent' do
    it 'returns announcements created in the last 7 days' do
      announcement = create(:announcement)
      expect(described_class.recent).to include(announcement)
    end

    it 'does not return announcements older than 7 days' do
      create(:announcement)
      travel_to 8.days.from_now do
        expect(described_class.recent).to be_empty
      end
    end
  end
end
