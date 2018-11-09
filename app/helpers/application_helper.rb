module ApplicationHelper
  def select_category_parent id
    Category.where parent_id: id
  end
end
