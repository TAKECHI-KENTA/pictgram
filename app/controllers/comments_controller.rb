class CommentsController < ApplicationController
  def index
    @comment_topics = current_user.comment_topics
  end
  
  def new
    @comment = Comment.new  #commentのnew.erb.htmlで入力された情報を格納する
    @topic_id = params[:topic_id] #commentのnew.erb.htmlでtopic_idを引き継ぐために情報を取得する
  end
  
  def create
    #@topic = Topic.find(params[:topic_id])
    comment = current_user.comments.new(comment_params)
    #comment.topic_id = topic.id
    
    if comment.save
      redirect_to topics_path, success: 'コメントに成功しました'
    else
      flash.now[:danger] = "コメントに失敗しました"
      render :new
    end 
  end 
  
  private
  def comment_params
    params.require(:comment).permit(:description, :topic_id)
  end 
end
