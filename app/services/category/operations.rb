class Category
  class Operations
    attr_reader :category, :group

    def initialize(category, group)
      @category  = category
      @group = group
    end

    def to_partial_path
      [group, :categories, :operations].compact.join('/')
    end
  end
end
