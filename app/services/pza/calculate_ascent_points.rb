module PZA
  class CalculateAscentPoints
    GRADES = %w{6a 6a+ 6b 6b+	6c 6c+ 7a 7a+ 7b 7b+ 7c 7c+ 8a 8a+ 8b 8b+ 8c 8c+ 9a 9a+ 9b 9b+}
    POINTS = { RP: 100, FLASH: 150, OS: 225 }

    def initialize(ascent)
      @ascent = ascent
    end

    def call
      return 0 if @ascent.line_grade < GRADES.first
      style_points + grade_points
    end

    private

    def style_points
      POINTS[@ascent.style.upcase.to_sym]
    end

    def grade_points
      grade = @ascent.line_grade.split('/').first
      GRADES.find_index(grade) * 50
    end
  end
end
