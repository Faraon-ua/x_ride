module ApplicationHelper
  def filter_checkbox(filter_param, value)
    checked = if params[filter_param].present?
                true if params[filter_param].include?(value.to_s)
              else
                false
              end

    check_box "filters", filter_param, {:multiple => true, :checked => checked}, value, nil
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == params[:sort] ? "current #{params[:direction]}" : nil
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, params.merge({:sort => column, :direction => direction}), {:class => css_class}
  end
end
