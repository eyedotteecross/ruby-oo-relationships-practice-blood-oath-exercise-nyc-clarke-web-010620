class Blood_oath
    
    @@all = []
    
    def initialize (follower, cult, initiation_date)
        @initiation_date = initiation_date
        @cult = cult
        @follower = follower
        @@all << self 
    end 
    
    attr_reader :initiation_date, :cult, :follower

    def self.all
        @@all 
    end 

    def self.find_by_initiation_date(date)
        matches = @@all.select{|blood_oath| blood_oath.initiation_date == date}
            if date.size != 10
            puts "Format is \"YYYY-MM-DD\""
            return "Invalid input. Please check format." 
            elsif date.length ==10 && matches.count > 0
            matches
            else
            puts "There are no Blood oaths matching that date."     
            end 
    end 

    def self.first_oath
       date = Blood_oath.all.map{|b_o| b_o.initiation_date}.map.min{|min,date| min <=> date}
       self.find_by_initiation_date(date)
    end    
end 

