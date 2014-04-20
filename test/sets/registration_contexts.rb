module Contexts
  module RegistrationContexts
    # create your contexts here...
    #assume that students and camps are created
    def create_registrations 
    	#@r1 = FactroyGirl.create(:registration, student: @eric, camp: @camp1)
    	@r2 = FactoryGirl.create(:registration, student: @kyle, camp: @camp2)
    	@r3 = FactoryGirl.create(:registration, student: @stan, camp: @camp1)

    end
    
    def delete_registrations
    	#@r1.delete
    	@r2.delete
    	@r3.delete
    end
  end
end