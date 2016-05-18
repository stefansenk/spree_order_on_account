
Spree::UserMethods.class_eval do

  def order_on_account?
    has_spree_role?('order_on_account')
  end

end
