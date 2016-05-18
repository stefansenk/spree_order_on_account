require 'spec_helper'

describe Spree::PaymentMethod::PaymentOnAccount do
  before do
    @payment_method = Spree::PaymentMethod::PaymentOnAccount.where(name: "Payment on account", description: "Pay on account.", active: true).first_or_create
    @order_on_account_role = FactoryGirl.create :role, name: 'order_on_account'
  end

  it "should be available for account holder that can order on account"  do
    @user = FactoryGirl.create :user, spree_roles: [@order_on_account_role]
    expect(@payment_method.available_to_user? @user).to be true
  end
  it "should not be available for a regular account holder"  do
    @user = FactoryGirl.create :user
    expect(@payment_method.available_to_user? @user).to be false
  end

  context "with an order" do
    before do
      @order = FactoryGirl.create :order, user: nil, email: 'spree@example.com'
    end
    it "should be available for an account holder that can order on account" do
      @order.user = FactoryGirl.create :user, spree_roles: [@order_on_account_role]
      expect(@order.available_payment_methods).to include @payment_method
    end
    it "should not be available for a regular account holder"  do
      @order.user = FactoryGirl.create :user
      expect(@order.available_payment_methods).not_to include @payment_method
    end
    it "should not be available for non-account holders"  do
      expect(@order.available_payment_methods).not_to include @payment_method
    end
  end

end
