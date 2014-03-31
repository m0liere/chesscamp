module NavigationHelpers
  def path_to(page_name)
    case page_name
 
    when /the home\s?page/
      '/'
    when /the About Us\s?page/
      about_path
    when /the Contact Us\s?page/
      contact_path
    when /the Privacy\s?page/
      privacy_path
    when /the curriculums\s?page/ 
      curriculums_path
    when /the principles details\s?page/
      curriculum_path(@principles)
    when /edit the nimzo\s?page/
      edit_curriculum_path(@nimzo)    
    when /the new curriculum\s?page/
      new_curriculum_path
    when /the instructors\s?page/ 
      instructors_path
    when /Mike Ferraco details\s?page/
      instructor_path(@mike)
    when /edit Patrick's\s?page/
      edit_instructor_path(@patrick)    
    when /the new instructor\s?page/
      new_instructor_path
    when /the camps\s?page/ 
      camps_path
    when /the camp1 details\s?page/
      camp_path(@camp1)
    when /edit camp1's\s?page/
      edit_camp_path(@camp1)  
    when /edit inactive camp's\s?page/
      edit_camp_path(@camp3)   
    when /the new camp\s?page/
      new_camp_path
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)