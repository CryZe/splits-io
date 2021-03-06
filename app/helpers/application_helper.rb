module ApplicationHelper
  def title(page_title)
    content_for(:title, page_title.to_s)
  end

  def order_runs(runs)
    col = params[:by] if [:created_at, :time, :user_id].map(&:to_s).include?(params[:by])
    dir = params[:order].to_sym if col && [:asc, :desc].map(&:to_s).include?(params[:order])
    runs.order((col || :created_at) => (dir || :desc))
  end

  def on_page
    {
      upload: request.path == new_run_path,
      games: request.path.match(games_path),
      faq: request.path == faq_path,
      profile: logged_in? && request.path == user_path(current_user)
    }
  end
end
