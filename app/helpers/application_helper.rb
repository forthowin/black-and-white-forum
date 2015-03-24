module ApplicationHelper
  def normalize_post_number(index)
    params[:page] ||= 1
    index + 1 + 10 * (params[:page].to_i - 1)
  end
end
