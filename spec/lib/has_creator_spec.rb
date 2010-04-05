require 'spec_helper'

describe HasCreator do
  attr_reader :user, :other_user

  before do
    @user = users(:rdy)
    @other_user = users(:jss)

    build_model :things do
      has_creator
    end
  end

  it "has the expected associations" do
    thing = Thing.create(:creator => user)
    thing.should belong_to(:creator)
  end

  it "has the expected validations" do
    thing = Thing.create(:creator => user)
    stub(User).current_user { nil }
    thing.should_not validate_presence_of(:creator_id)
    stub(User).current_user { user }
    thing.should validate_presence_of(:creator_id)    
  end

  it "has the expected permissions" do
    thing = Thing.create(:creator => user)
    thing.should be_creatable_by(user)
    thing.should be_readable_by(user)
    thing.should be_updatable_by(user)
    thing.should be_destroyable_by(user)

    thing.should_not be_creatable_by(other_user)
    thing.should be_readable_by(other_user)
    thing.should_not be_updatable_by(other_user)
    thing.should_not be_destroyable_by(other_user)    
  end
end