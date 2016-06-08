class Seeder

  def self.seed!
    self.users
    self.tasks
  end

  def self.users
    User.create(first_name: "Eric", last_name: "Pihlgren", mail: "abc@xyz.io", username: "ericp", password: "password")
  end

  def self.tasks
    Task.create(user_id: 1, title: "Hej", description: "ejhklö")
    Task.create(user_id: 1, title: "Hsdasadas", description: "ejhklö")
  end





end