class User
  class Operations
    attr_reader :user, :group

    def initialize(user, group)
      @user  = user
      @group = group
    end

    def to_partial_path
      [group, :users, :operations].compact.join('/')
    end
  end
end
