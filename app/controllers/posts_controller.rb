class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy, :save]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destory]

   def index
     @posts = Post.includes(:comment_threads).page(params[:page])
   end

   def show
     @comment = Comment.build_from(@post, current_user.id, '') if user_signed_in?
   end

   def new
     @post = Post.new
     @post.post_type = params[:post_type] if params[:post_type].present?
   end

   def create
     @post = Post.new post_params
     @post.user_id = current_user.id
     if @post.save
       redirect_to posts_path, flash: { 'alert-success' => "Thanks for submitting your post!" }
     else
      flash.now[:'alert-danger'] = @post.errors.full_messages
      render :new
     end
   end

   def edit
   end

   def update
     if @post.update post_params
       redirect_to posts_path, flash: { 'alert-success' => "Your post has been updated." }
     else
       flash.now[:'alert-danger'] = @post.errors.full_messages
       render :edit
     end
   end

   def destroy
     if @post.destroy
       redirect_to posts_path, flash: { :'alert-success' => "Your post has been deleted."}
     else
       redirect_to posts_path, flash: { :'alert-danger' => "That post could not be deleted. It was probably gone."}
     end
   end

   def save
     Enotes.create_from @post
     redirect_to @post, :'alert-success' => 'Saved to Enote!'
   rescue
     redirect_to @post, :'alert-danger' => 'We were unalble to save that to Enotes.'
   end

  private

   def find_post
     @post = Post.find params[:id]
   end

   def post_params
     params.require(:post).permit(:title, :link, :body, :post_type, :category_id, :parent_id)
   end

end
