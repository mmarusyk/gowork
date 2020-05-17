module ApplicationHelper
  def full_title(page_title = '')
    base_title = "GoWork App"
    if page_title.empty?
      base_title
    else page_title + " | " + base_title
    end
  end

  def info_about_proposals(status = '')
    if status == 'Активне'
      "Пропозиції  (#{@order.proposals.count})"
    else
      "Виконується"  
    end
  end
end
