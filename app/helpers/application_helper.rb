module ApplicationHelper

  def name_with_status(name, status, user_id)
    link_to(name, user_path(user_id), :class => "name") +
      content_tag(:span, status, :class => "status status-#{status}") +
      link_to("Update", status_user_path(user_id), :class => "update-link")
  end

  def link_to_team(user)
    link_to(user.team.name, root_path(team_id: user.team.id)) unless user.team.blank?
  end
end
