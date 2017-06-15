class Student
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = File.read('db/create_table.sql')
        DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students;"
    DB[:conn].execute(sql)
  end

  def save
    id_query = "SELECT COUNT(*) FROM students;"
    @id = DB[:conn].execute(id_query).flatten[0] + 1
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
    arr = DB[:conn].execute(sql, [self.name, self.grade])
    # @id =
  end

  def self.create(name:, grade:)
    new_student = self.new(name, grade)
    new_student.save
    new_student
  end

end
