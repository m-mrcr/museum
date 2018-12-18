class Museum

  attr_reader :name,
              :exhibits

  def initialize(name)
    @name = name
    @exhibits = []
  end

  def add_exhibit(exhibit)
    @exhibits.push(exhibit)
  end

  def recommend_exhibits(patron)
    recommendations = []
    patron.interests.each do |interest|
      @exhibits.each do |exhibit|
        if exhibit.name.include?(interest)
          recommendations.push(exhibit)
        end
      end
    end
    recommendations
  end

  def patrons_by_exhibit_interest
    exhibits = {}

    
  end



end
