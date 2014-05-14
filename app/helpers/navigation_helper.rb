module NavigationHelper
  def path_active(path)
    yield path, path_active?(path)
  end

  def path_active?(path)
    @breadcrumbs.any? do |breadcrumb|
      breadcrumb_path = breadcrumb.path
      breadcrumb_path =  send(breadcrumb_path) if breadcrumb_path.is_a? Symbol
      breadcrumb_path == path
    end
  end

  def path_active_class(path)
    path ? :active : nil
  end
end
