require 'spec_helper'

describe Application::TwitterConfig do
  it { should respond_to(:token) }
  it { should respond_to(:secret) }
  it { should respond_to(:callback) }  
end
