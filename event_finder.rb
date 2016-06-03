require_relative 'spec_helper'

# The responsibility of this class is to take in a user's record
# and a feed of events, and return a filtered list of events based
# on the requested conditions
class EventFinder
  def self.get_event_ids(data, org_id)
    data.select {|i| i[1]==org_id}.map {|i| i[0]}
  end
end

# Acceptance criteria:
# 1. Filter out events for organizations that the user does not subscribe to
# 2. Filter out events in the past (by default)
# 3. Return the list grouped by organization, and sorted by date ASC
# 4. Limit the list to the next 5 events per organization (by default)
# 5. Allow the following configuration options:
#    a. Set a custom limit to the events per organization
#    b. Set an inclusive date range
#    c. Select by category/type
describe EventFinder do
  describe '#get_event_ids' do
    it 'returns a list of events filtered by the requested org_id' do
      data = [[5, 1], [16, 2], [8, 1]]
      ids = EventFinder.get_event_ids(data, 1)
      expect(ids).to eq [5, 8]
    end
  end

  describe '#get_events' do
    it 'returns a list of events filtered by the subscriptions of the user' do
      race = {name: 'Race for the Cure', org_id: 8}
      walk = {name: '50th Annual AIDS Walk', org_id: 9}
      fuck = {name: 'Fuck Cancer', org_id: 8}
      toys = {name: 'Toys For Tots', org_id: 10}
      events_feed = [race, walk, fuck, toys]

      user = {
        id: 1,
        name: 'Jordan',
        subscribed_organizations: [7, 8, 10]
      }

      expected_events = [race, fuck, toys]
      actual_events = EventFinder.get_events(user, events_feed)
      expect(actual_events).to eq expected_events
    end
  end
end
