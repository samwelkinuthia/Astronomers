class LinksController < ApplicationController
  before_action :prevent_unauthorized_user_access, only: %i[new edit]

  def show
    @link=Link.find_by(id: params[:id])
    @comments=@link.comments
  end

  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.new(link_params)

    if @link.save
      redirect_to root_path, notice: 'Link successfully created'
    else
      render :new
    end
  end

  def edit
    link = Link.find_by(id: params[:id])

    if current_user.owns_link?(link)
      @link = link
    else
      redirect_to root_path, notice: 'Not authorized'
    end
  end

  def destroy
    link = Link.find_by(id: params[:id])
    if current_user.owns_link?(link)
      link.destroy
      redirect_to root_path, notice: 'Link deleted'
    else
      redirect_to root_path, notice: 'Not authorized'
    end
  end

  def update
    @link = current_user.links.find_by(id: params[:id])
    if @link.update(link_params)
      redirect_to root_path, notice: 'Updated'
    else
      render :edit
    end
  end
#upvote method for links
  def upvote
    link = Link.find_by(id: params[:id])
    if current_user.upvoted?(link)
      current_user.remove_vote(link)
    else
      current_user.upvote(link)
    end

    redirect_to root_path
  end
#downvotes
  private

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end
end
