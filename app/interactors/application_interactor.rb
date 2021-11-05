class ApplicationInteractor
  include Interactor

  def self.parameters(*parameters)
    delegate *parameters, to: :context
    parameters.each do |parameter|
      method_name = "update_#{parameter}"
      define_method(method_name) do |new_value|
        context.send("#{parameter}=", new_value)
      end
    end
  end
end
