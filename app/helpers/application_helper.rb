module ApplicationHelper
  def link path
    "/#{locale}" + path
  end
end
