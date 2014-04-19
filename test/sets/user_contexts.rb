module Contexts
  module UserContexts
    # create your contexts here...
    #assumes create_more_instructors run before this
    def create_users
    	@fabio = FactoryGirl.create(:user, instructor: @mike, active: false)
    	@suarez = FactoryGirl.create(:user, instructor: @ari, username:'luis7suarez', password_digest: 'goldenboot', role:'admin')
    	@studge = FactoryGirl.create(:user, instructor: @jon, username:'redordead', password_digest: 'lfcforthetitle', role:'admin')
    end

    def delete_users
    	@fabio.delete
    	@suarez.delete
    	@studge.delete
    end

  end
end