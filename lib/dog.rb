require 'pry'

class Dog
  attr_accessor :name, :breed, :id

  def initialize(id: nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
        )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS dogs")
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO dogs (name, breed)
        VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end
    self
  end

  def self.create(name:, breed:)
    dog = Dog.new(name: name, breed: breed)
    dog.save
    dog
  end

  def self.find_by_id(num)
    sql = <<-SQL
    SELECT *
    FROM dogs
    WHERE id = #{num}
    SQL

    dog_info = DB[:conn].execute(sql).flatten

    id = dog_info[0]
    name = dog_info[1]
    breed = dog_info[2]
    Dog.new(id: id, name: name, breed: breed)
    # binding.pry
  end

  def self.find_or_create_by(name:, breed:)
    sql = <<-SQL
    SELECT *
    FROM dogs
    WHERE name = #{name}
    AND breed = #{breed}
    SQL
    
   dog = DB[:conn].execute(sql)
   
   if !song.empty?
     song_data = song[0]
     song = Song.new(song_data[0], song_data[1], song_data[2])
   else
     song = self.create(name: name, album: album)
   end
   song
 end 

end
