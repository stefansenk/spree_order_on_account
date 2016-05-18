require 'spec_helper'

describe Spree::UserMethods do
  before do
    @role = FactoryGirl.create :role, name: 'order_on_account'
  end
  it "should be able to order on account" do
    @user = FactoryGirl.create :user, spree_roles: [@role]
    expect(@user.order_on_account?).to be true
  end
  it "should not be able to order on account" do
    @user = FactoryGirl.create :user
    expect(@user.order_on_account?).to be false
  end
end
