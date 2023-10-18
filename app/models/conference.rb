class Conference < ApplicationRecord

  def self.insert_conferences_in_bulk(bulk_conferences)
    Conference.insert_all!(bulk_conferences)
  end
end
