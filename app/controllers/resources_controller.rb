class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :set_collection, only: [:new, :create, :edit, :update, :destroy]

  # CRUD Actions
  def index
    # no use of index
  end

  def show
    # the @resource variable has been set with the before_action 'set_resource' method.
  end

  def new
    @resource = Resource.new
    authorize @resource
  end

  def create
    @resource = Resource.new(resource_params)
    @resource.collection = @collection
    authorize @resource
    @resource.save
    redirect_to collection_path(@collection)
  end

  def edit
    # the @resource and @collection variable have been set with the before_action 'set_link' and 'set_collection' methods.
  end

  def update
    @resource.update(resource_params)
    redirect_to collection_path(@collection)
  end

  def destroy
    @resource.destroy
    redirect_to collection_path(@collection)
  end

  # Non-CRUD Actions

  def upvote
    @resource.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @resource.downvote_by current_user
    redirect_to :back
  end

  private

  def resource_params
    params.require(:resource).permit(:title, :content, :uri)
  end

  def set_resource
    @resource = Resource.find(params[:id])
    authorize @resource
  end

  def set_collection
    @collection = Collection.find(params[:collection_id])
  end
end
