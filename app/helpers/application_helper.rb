module ApplicationHelper
  def active?(controllers)
    controllers.include?(params[:controller]) ? 'active' : nil
  end
end
