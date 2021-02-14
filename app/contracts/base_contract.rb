class BaseContract < Dry::Validation::Contract
  def self.call(params)
    new.call(params)
  end
end
