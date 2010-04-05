module HasCreator
  module ActiveRecord
    def self.included(base)
      base.extend Has
    end

    module Has
      def has_creator
        belongs_to :creator, :class_name => "User"
        before_validation :load_creator
        validates_presence_of :creator_id, :unless => lambda { User.current_user.nil? }
        include HasCreator::ActiveRecord::InstanceMethods
      end
    end

    module InstanceMethods
      def readable_by?(user)
        true
      end
      def creatable_by?(user)
        self.creator == user
      end
      def updatable_by?(user)
        self.creator == user
      end
      def destroyable_by?(user)
        self.creator == user
      end

      private
      def load_creator
        self.creator ||= User.current_user
      end
    end
  end
end
