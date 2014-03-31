FactoryGirl.define do
  
  factory :curriculum do
    name "Mastering Chess Tactics"
    description "This camp is designed for any student who has mastered basic mating patterns and understands opening principles and is looking to improve his/her ability use chess tactics in game situations."
    min_rating 400
    max_rating 850
    active true
  end
  
  factory :instructor do
    first_name "Mark"
    last_name "Heimann"
    bio "Mark is currently among the top 100 players in the United States and has won 4 national scholastic chess championships."
    email { |a| "#{a.first_name}.#{a.last_name}@example.com".downcase }
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    active true
  end
  
  factory :camp do 
    cost 125
    start_date Date.new(2014,7,14)
    end_date Date.new(2014,7,18)
    time_slot "am"
    max_students 8
    active true
    association :curriculum
  end
  
  factory :camp_instructor do 
    association :camp
    association :instructor
  end
  
end