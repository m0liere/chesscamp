require './test/contexts'
include Contexts

Given /^an initial setup$/ do
  # minimal context used in unit testing
  create_curriculums
  create_instructors
  create_camps
  create_camp_instructors
end

Given /^a large set of curriculums and camps$/ do
  create_curriculums
  create_instructors
  create_camps
  create_camp_instructors
  create_more_curriculums  # total of 9 curriculums; 7 active (tal, smith-morra inactive)
  create_past_camps        # add 4 camps in past
  create_upcoming_camps    # total of 16 camps; 12 upcoming; camp3 inactive
  # see below for array showing how often each curriculum was used in a camp
  # [["Mastering Chess Tactics", 3], ["Endgame Principles", 1], ["Smith-Morra Gambit", 0], ["The Tactics of Tal", 0], ["Nimzo-Indian Defense", 3], ["Principles of Chess", 5], ["Positional Understanding", 2], ["Advanced Tactics Training", 1], ["Chess Opening for Beginners", 1]]
end

Given /^a large set of camps and instructors$/ do
  create_curriculums
  create_instructors
  create_camps
  create_camp_instructors
  create_more_curriculums
  create_more_instructors  # total of 15 instructors; only rachel inactive
  create_past_camps
  create_upcoming_camps
  create_more_camp_instructors  # see below for counts of camps by each instructor...
  # alex(2), ari(2), ashton(1), austin(1), brad(1), mark(3), mike(3), nathan(1), patrick(1), 
  # seth(1), stafford(1), jon(0), ripta(0), noah(0), rachel(0)
  # unassigned camps: camp26 (principles), camp27 (nimzo), and camp3 (tactics)
end
