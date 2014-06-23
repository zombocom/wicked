class Nested
  attr_reader :id

  def self.primary_key
    :id
  end

  def save
    @id = 'persisted'
    true
  end
end
