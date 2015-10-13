module CommentsHelper

  def comment_info (count)
    if count < 1
      'No comments yet.'
    else
      pluralize(count, 'comment')
    end
  end

end
