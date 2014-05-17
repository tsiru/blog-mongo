class Post
  class Operations
    attr_reader :post, :group

    def initialize(post, group)
      @post  = post
      @group = group
    end

    def to_partial_path
      [group, :posts, :operations].compact.join('/')
    end
  end
end
