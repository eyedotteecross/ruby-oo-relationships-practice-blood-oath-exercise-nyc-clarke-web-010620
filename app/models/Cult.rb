require 'pry'


class Cult
    
    @@all = []

    def initialize(name,location,founding_year,slogan,minimum_age=18) 
        @name = name 
        @location = location
        @founding_year = founding_year
        @slogan = slogan
        @minimum_age = minimum_age
        @@all << self 
    end 
    
    attr_accessor :name, :followers, :location, :slogan, :minimum_age
    attr_reader :founding_year, :blood_oaths


    def recruit_follower(follower)
        if follower.age < self.minimum_age
            p "New recruit does not meet the mandatory age requirement!"
        elsif !self.followers.include?(follower)
            puts "What is the initiation date? Format:YYYY-MM-DD"
            date = gets.chomp
            Blood_oath.new(follower,self,date) 
        else
            p "#{follower.name} is already a member of #{self.name}!" 
        end 
    end 

    def blood_oaths
        Blood_oath.all.select do |blood_oath|
        blood_oath.cult == self
        end
    end

    def followers
        self.blood_oaths.map do |blood_oaths|
        blood_oaths.follower
        end
    end

    def cult_population
        self.followers.size
    end 

    def self.all
        @@all    
    end 

    def self.find_by_name(cult_obj)
        match = @@all.find{|cult| cult.name.upcase == cult_obj.name.upcase}
            if !match
            "No cults with that name were found."
            else 
            match       
            end 
    end
    
    def self.find_by_location(location)
        cults_at_location = @@all.select {|cult| cult.location.upcase == location.upcase}
            if cults_at_location.count < 1
            "No cults were found in #{location}."
            else cults_at_location 
            end 
    end 

    def self.find_by_founding_year(founding_year) 
        cults_in_year = @@all.select {|cult| cult.founding_year == founding_year}
            if cults_in_year.count < 1
            "There are no cults matching that founding year."    
            else cults_in_year 
            end 
    end 

    def average_age 
        if self.followers.size > 0
        self.followers.inject(0){|sum,x| sum + x.age }/self.followers.size
        else
        puts "There are no members in #{self}"    
        end 
    end 
    
    def my_followers_mottos
        self.followers.map{|follower| follower.life_motto}    
    end 

    def self.least_popular
        least_members_amount = @@all.min {|a,b| a.cult_population <=> b.cult_population}.followers.size 
        self.all.select {|cult| cult.cult_population == least_members_amount}
    end 

    def self.most_common_location 
        locations = @@all.map {|cult| cult.location}
        locations.max_by { |i| locations.count(i) }
    end
end 

