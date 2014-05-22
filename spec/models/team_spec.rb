require 'spec_helper'

describe Team do

  it { should have_many(:users) }
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}

  it { should respond_to :name }

end
