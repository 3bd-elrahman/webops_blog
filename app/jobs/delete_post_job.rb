class DeletePostJob < ApplicationJob
  queue_as :default

  def perform(*args)
  
    Post.all.each do |post|
        time_ago_of_post = (Time.now.utc - post.created_at)/1.hour
        
        if time_ago_of_post >= 24
          post.destroy
        end
    end
  end
end
