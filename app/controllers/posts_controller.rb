class PostsController < ApplicationController
   def index
     @posts = Post.all
   end

   def new
     @post = Post.new
   end

   def create
     post = Post.new(params.require(:post).permit(:title, :link, :body))
     if post.save
     else redirect_to new_post_path
     redirect_to posts_path
     end
   end
end
