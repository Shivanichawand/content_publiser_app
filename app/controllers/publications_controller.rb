class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show, :update, :destroy]

  def index
    render json: Publication.all
  end

  def show
    render json: @publication
  end

  def create
    publication = @current_user.publications.new(publication_params)
    if publication.save
      render json: publication, status: :created
    else
      render json: { errors: publication.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @publication.update(publication_params)
      render json: @publication
    else
      render json: { errors: @publication.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @publication.destroy
      render json: { message: 'Publication deleted successfully' }
    else
      render json: { error: 'Failed to delete' }, status: :unprocessable_entity
    end
  end

  private

  def set_publication
    @publication = Publication.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Publication not found" }, status: :not_found
  end

  def publication_params
    params.require(:publication).permit(:title, :content, :status)
  end
end
