class CommentsController < ApplicationController
  load_and_authorize_resource :post
  load_and_authorize_resource through: :post

  def create
    @comment.update_attributes(params[:comment])
    if @comment.valid?
      flash[:success] = 'Post has been commented'
    else
      flash[:error] = 'An arror ocurred, please try again.'
    end
    respond_with @comment, location: post_path(@post)
  end

  def destroy
    @comment.destroy
    respond_with @comment, location: post_path(@post)
  end
end
