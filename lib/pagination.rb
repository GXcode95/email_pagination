module Pagination
  MIN_PAGE = 1

  def paginate(collection, params, page_size)
    max_pages = count_pages(collection, page_size)
    page = [params.to_i, MIN_PAGE].max
    page = [page, max_pages].min 
    collection_index = set_collection_index(page)
    emails = collection.offset(page_size * collection_index ).limit(page_size)

    [page, max_pages, emails]
  end

  def count_pages(collection, page_size)
    (collection.count.to_f / page_size.to_f).ceil
  end

  def set_collection_index(page = 0)
    return 0 if page < MIN_PAGE
    page - 1
  end
end