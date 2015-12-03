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
      expected = [announcement]
      result = described_class.recent
      expect(expected).to eq(result)
    end

    it 'does not return announcements older than 7 days' do
      create(:announcement, created_at: 8.days.ago)
      expected = []
      result = described_class.recent
      expect(expected).to eq(result)
    end
  end
end
