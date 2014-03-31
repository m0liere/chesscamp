namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Drop the old db and recreate from scratch
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    # Invoke rake db:migrate
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
    # Need gem to make this work when adding students later: faker
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'

    # Step 1: Create some instructors
    mark = Instructor.new
    mark.first_name = "Mark"
    mark.last_name = "Heimann"
    mark.bio = "Mark is currently among the top 100 players in the United States (USCF rating: 2449) and has won 4 national scholastic chess championships.  Mark attends Washington University in St. Louis where he majors in mathematics and economics and plays first board for the school's chess team."
    mark.email = "mark@razingrooks.org"
    mark.phone = "412-268-2323"
    mark.active = true
    mark.save!

    alex = Instructor.new
    alex.first_name = "Alex"
    alex.last_name = "Heimann"
    alex.bio = "Alex has earned his Life Master title with a current USCF rating of 2374.  Alex has won 4 national scholastic chess championships as well as 2 national bughouse championships.  Alex attends Wheaton College in Illinios where he majors in business with a minor in anthropology and plays ultimate frisbee."
    alex.email = "alex@razingrooks.org"
    alex.phone = "412-268-3259"
    alex.active = true
    alex.save!

    rachel = Instructor.new
    rachel.first_name = "Rachel"
    rachel.last_name = "Heimann"
    rachel.bio = "Rachel is an amazing chess player and regularly beats her brothers, Alex and Mark.  Unfortunately she is currently unable to teach for any of the chess camps at this time."
    rachel.email = "rachel@razingrooks.org"
    rachel.phone = "412-268-8211"
    rachel.active = false
    rachel.save!

    # Step 2: Create some curriculum
    beginners = Curriculum.new
    beginners.name = "Principles of Chess"
    beginners.min_rating = 0
    beginners.max_rating = 400
    beginners.description = "This camp is designed for beginning students who know need to learn opening principles, pattern recognition and basic tactics and mates.  Students will be given a set of mate-in-one flashcards and are expected to work on these at home during the week."
    beginners.active = true
    beginners.save!

    tactics = Curriculum.new
    tactics.name = "Mastering Chess Tactics"
    tactics.min_rating = 400
    tactics.max_rating = 850
    tactics.description = "This camp is designed for any student who has mastered basic mating patterns and understands opening principles and is looking to improve his/her ability use chess tactics in game situations. Students will be given a set of tactical flashcards and are expected to work on these at home during the week."
    tactics.active = true
    tactics.save!

    tal = Curriculum.new
    tal.name = "The Tactics of Mikhail Tal"
    tal.min_rating = 800
    tal.max_rating = 3000
    tal.description = "Tal is one of the most admired world champions and often called the Wizard from Riga for his almost magical play.  His chess genius was most clearly seen in his amazing sacrifices and dazzling tactics and in this camp we will dissect these thoroughly so students can learn from them."
    tal.active = false
    tal.save!

    nimzo = Curriculum.new
    nimzo.name = "Nimzo-Indian Defense"
    nimzo.min_rating = 1000
    nimzo.max_rating = 3000
    nimzo.description = "This camp is for intermediate and advanced players who are looking for a good defense to play against 1. d4.  Many world champions, including Mikhail Tal and Garry Kasparov, have played this defense with great success.  Students will have 4 to 6 games to review each day at home as homework."
    nimzo.active = true
    nimzo.save!

    endgames = Curriculum.new
    endgames.name = "Endgame Principles"
    endgames.min_rating = 750
    endgames.max_rating = 1500
    endgames.description = "In this camp we focus on mastering endgame principles and tactics.  We will focus primarily on King-pawn and King-rook endings, but other endings will be covered as well. Complete games will not be played during this camp, but students will compete through a series of endgame exercises for points and awards."
    endgames.active = true
    endgames.save!

    # Step 3: Create some camps
    camp1 = Camp.new
    camp1.curriculum_id = beginners.id
    camp1.cost = 125
    camp1.start_date = Date.new(2014,7,14)
    camp1.end_date = Date.new(2014,7,18)
    camp1.time_slot = "am"
    camp1.max_students = 8
    camp1.active = true
    camp1.save!

    camp2 = Camp.new
    camp2.curriculum_id = tactics.id
    camp2.cost = 125
    camp2.start_date = Date.new(2014,7,14)
    camp2.end_date = Date.new(2014,7,18)
    camp2.time_slot = "pm"
    camp2.max_students = 8
    camp2.active = true
    camp2.save!

    camp3 = Camp.new
    camp3.curriculum_id = nimzo.id
    camp3.cost = 150
    camp3.start_date = Date.new(2014,7,21)
    camp3.end_date = Date.new(2014,7,25)
    camp3.time_slot = "am"
    camp3.max_students = 8
    camp3.active = true
    camp3.save!

    camp4 = Camp.new
    camp4.curriculum_id = beginners.id
    camp4.cost = 125
    camp4.start_date = Date.new(2014,7,21)
    camp4.end_date = Date.new(2014,7,25)
    camp4.time_slot = "pm"
    camp4.max_students = 8
    camp4.active = true
    camp4.save!

    camp5 = Camp.new
    camp5.curriculum_id = endgames.id
    camp5.cost = 125
    camp5.start_date = Date.new(2014,7,28)
    camp5.end_date = Date.new(2014,8,1)
    camp5.time_slot = "am"
    camp5.max_students = 8
    camp5.active = true
    camp5.save!

    camp6 = Camp.new
    camp6.curriculum_id = tactics.id
    camp6.cost = 130
    camp6.start_date = Date.new(2014,8,4)
    camp6.end_date = Date.new(2014,8,8)
    camp6.time_slot = "pm"
    camp6.max_students = 8
    camp6.active = true
    camp6.save!

    # Step 4: Assign instructors to camps
    cc1 = CampInstructor.new
    cc1.camp_id = camp1.id
    cc1.instructor_id = mark.id
    cc1.save!

    cc2 = CampInstructor.new
    cc2.camp_id = camp1.id
    cc2.instructor_id = alex.id
    cc2.save!

    cc3 = CampInstructor.new
    cc3.camp_id = camp2.id
    cc3.instructor_id = alex.id
    cc3.save!

    cc4 = CampInstructor.new
    cc4.camp_id = camp3.id
    cc4.instructor_id = mark.id
    cc4.save!

    cc5 = CampInstructor.new
    cc5.camp_id = camp4.id
    cc5.instructor_id = mark.id
    cc5.save!

    cc6 = CampInstructor.new
    cc6.camp_id = camp4.id
    cc6.instructor_id = alex.id
    cc6.save!

    cc7 = CampInstructor.new
    cc7.camp_id = camp5.id
    cc7.instructor_id = mark.id
    cc7.save!

  end
end