class AnnouncementDecorator < Draper::Decorator
  SHORT_DESCRIPTION_LENGTH = 600

  delegate_all

  def headline
    h.image_tag('news.png', class: 'header').concat(h.content_tag :h3, model.headline)
  end

  def posted_by
    h.content_tag :div, class: 'muted' do
      "Posted by #{announcement.posted_by} #{h.local_time_ago(announcement.created_at)}".html_safe
    end
  end

  def full_description
    h.simple_format(model.description)
  end

  def short_description
    h.simple_format(h.truncate(model.description, length: SHORT_DESCRIPTION_LENGTH) { h.link_to 'Read full article', model })
  end
end
