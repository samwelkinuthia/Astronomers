class LinksController < ApplicationController
  before_action :prevent_unauthorized_user_access, only: %i[new edit]

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

  private

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end
end
