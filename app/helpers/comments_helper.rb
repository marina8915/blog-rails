module CommentsHelper
  def nested_comments(comments)
    comments.map do |comment|
      content_tag(:div, render(comment), :class => "reply-comment")
    end.join.html_safe
  end
end
