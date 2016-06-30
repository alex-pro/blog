module ApplicationHelper
  def can_user(object)
    current_user && object.user_id == current_user.id
  end

  def current_page(object)
    'active' if object == params[:controller]
  end

  def friend_present(object)
    current_user && current_user.friendships.map(&:friend_id).include?(object)
  end

  # def sortable(column, title = nil)
  #   title ||= column.titleize
  #   css_class = column == sort_column ? "current #{sort_direction}" : nil
  #   direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  #   link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  # end
end
