class LinksController < ApplicationController
  before_action :prevent_unauthorized_user_access, only: %i[new edit]

  def index
    @Links = Link.all
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

  private

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end
end
