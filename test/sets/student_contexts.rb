module Contexts
  module StudentContexts
    # create your contexts here...
    def create_students
    	@eric = FactoryGirl.create(:student)
    	@kenny = FactoryGirl.create(:student, first_name: 'Kenny', last_name: 'Mccormick', active: false, rating: nil )
    	@kyle = FactoryGirl.create(:student, first_name: 'Kyle', last_name: 'Brovslovski', rating: 2999)
    	@stan = FactoryGirl.create(:student, first_name: 'Stan', last_name: 'Marsh', rating:1000)
    end

    def delete_students
    	@eric.destroy
    	@kenny.destroy
    	@kyle.destroy
    	@stan.destroy
    end
  end
end