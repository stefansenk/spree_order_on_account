Spree::Order.class_eval do
  def available_payment_methods
    @available_payment_methods ||= Spree::PaymentMethod.available_on_front_end.select do |method|
      method.respond_to?(:available_to_user?) ? method.available_to_user?(user) : true
    end
  end
end
