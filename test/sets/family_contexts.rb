module Contexts
  module FamilyContexts
    # create your contexts here...
    def create_families
    	@cartman = FactoryGirl.create(:family)
    	@marsh = FactoryGirl.create(:family, family_name: 'Marsh')
    	@brov = FactoryGirl.create(:family, family_name: 'Brovslovki')
    	@mc = FactoryGirl.create(:family, family_name: 'Mccormick')
  	end

  	def delete_families 
  		@cartman.destroy
  		@marsh.destroy
  		@brov.destroy
  		@mc.destroy
  	end
  end
end