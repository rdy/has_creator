require 'has_creator'

ActiveRecord::Base.class_eval do
  include HasCreator::ActiveRecord
end