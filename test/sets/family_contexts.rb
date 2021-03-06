module Contexts
  module FamilyContexts
    # create your contexts here...
    def create_families
    	@cartman = FactoryGirl.create(:family)
    	@mc = FactoryGirl.create(:family, family_name: 'Mccormick')
    	@brov = FactoryGirl.create(:family, family_name: 'Brovslovski')
    	@marsh = FactoryGirl.create(:family, family_name: 'Marsh')


  	end

  	def delete_families 
  		@cartman.delete
  		@marsh.delete
  		@brov.delete
  		@mc.delete
  	end
  end
end