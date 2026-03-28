# Plain JSON helper (not active_model_serializers — that gem is not in the Gemfile).
class PageSerializer
  def self.one(page)
    {
      current_page: page.current_page,
      next_page: page.next_page,
      prev_page: page.prev_page,
      total_pages: page.total_pages,
      total_count: page.total_count
    }
  end
end
