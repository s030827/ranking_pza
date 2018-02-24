module ApplicationHelper
  def rows_count
    ((params[:page] || 1).to_i - 1) * Kaminari.config.default_per_page
  end
end
