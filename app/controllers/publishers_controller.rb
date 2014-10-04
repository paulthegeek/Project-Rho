class PublishersController < ApplicationController
  respond_to :json

  def index
    @publishers = Publisher.all.order('id asc')
  end

  def show
    @publisher = Publisher.find(params[:id])
  end

  def new
    @publisher = Publisher.new
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def update
    @publisher = Publisher.find(params[:id])

    respond_to do |format|
      if @publisher.update_attributes(publisher_params)
        format.json { render json: @publisher, status: :ok, location: @publisher }
      else
        format.json { render json: @publisher.errors, status: :unprocessable_entity}
      end
    end
  end

  def create
    @publisher = Publisher.new(publisher_params)

    respond_to do |format|
      if @publisher.save
        format.json { render json: @publisher, status: :created, location: @publisher }
      else
        format.json { render json: @publisher.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @publisher = Publisher.find(params[:id])
    @publisher.archive
    head status: :no_content
  end

  def publisher_params
    params.require(:publisher).permit(:name, :archived)
  end
end
