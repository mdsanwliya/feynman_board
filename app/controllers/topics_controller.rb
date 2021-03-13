class TopicsController < ApplicationController
  def index
    @topics = current_user.topics
  end

  def new
    @topic = Topic.new
  end

  def create
    topic = current_user.topics.new(topic_param)
    if topic.save
      redirect_to topics_path
    else
      render :new
    end
  end

  private

  def topic_param
    params.require(:topic).permit(:title, :description, :user_id)
  end
end
