module Contexts
  module LocationContexts
    # create your contexts here...
    def create_locs
    	@home = FactoryGirl.create(:location)
    	sleep 1
    	@fairfax = FactoryGirl.create(:location, name: 'Fairfax', street_1:'4146 Fifth Ave', state: 'PA', zip: '15213')
    	sleep 1
    	@skid = FactoryGirl.create(:location, name: 'Skidmore', street_1:'815 N Broadway', state: 'NY', zip: '12866')
    	sleep 1
    end
    
    def delete_locs
    	@home.delete
    	@fairfax.delete
    	@skid.delete
    end
  end
end