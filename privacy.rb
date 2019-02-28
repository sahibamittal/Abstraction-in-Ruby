# super-class
class Medicine_Study

  attr_accessor :studyNumber, :studyName, :status, :numberOfPatients

  #by-default private method
  # can only be accessed by other instance methods in this class
  def initialize(n,name)
    @studyNumber = n
    @studyName = name
    @status = "Inactive"
    @numberOfPatients = 0
  end

  # private method - called by class instance method 'add_patient' to change the status of study
  def set_status
    puts "\n***private method 'set_status' calling protected method 'hasPatients?' of its class internally to check if this study has any patients or not."
    if self.hasPatients?
      then @status = "Active"
    else
      @status = "Inactive"
    end
  end

  # protected method - to be used by set_status internally in class only using 'self'
  def hasPatients?
    return @numberOfPatients > 0
  end

  # public method - invoked by sub-class to update private attribute of super-class
  def addPatient
    puts "\n***'addPatient' doing its work and then calling private method of its class 'set_status' to update status of this study***"
    @numberOfPatients += 1
    set_status
  end

  def call_private
    puts "I am private method. I cannot be accessed directly! Only other instance methods of my class or sub-class can access me like you just did."
  end

  private :call_private
  private :set_status
  protected :hasPatients?
  public :addPatient
end

# sub-class for patients participating in studies
class Patient < Medicine_Study

  attr_accessor :name, :age, :country

  def initialize(name, age, country)
    @name = name
    @age = age
    @country = country
  end

  # sub-class instance method to call private method of super-class
  # NOTE: Private methods can be invoked by other instance methods of its class or sub-classes
  def print(obj)
    puts "\nPatient named #{@name} aged #{age} years belonging from #{@country} is assigned to study : '#{@studyName}'"
    puts "\nCalling private method of super-class : "
    call_private
  end

  # public class being called outside the class bodies
  def assign(obj)
    @studyNumber =obj.studyNumber
    @studyName = obj.studyName
    @status = obj.status
    @numberOfPatients = obj.numberOfPatients
    puts "\n***Sub-class method calling public method 'addPatient' of super-class to add a patient under the study being assigned***"
    obj.addPatient
  end

  public :assign
end

# top-level script

study1 = Medicine_Study.new(1450, "Dopamine_Effects")
puts study1.inspect
patient1 = Patient.new("Jane", 34, "Australia")
puts patient1.inspect

# calling public method of sub-class outside the class body
puts "\nAssigning patient to the study : "
patient1.assign(study1)
puts patient1.print(study1)