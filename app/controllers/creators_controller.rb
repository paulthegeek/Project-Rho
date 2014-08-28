class CreatorsController < ApplicationController
  def index
    @creators = Creator.all.order('id asc')
  end

  def show
    @creator = Creator.find(params[:id])
  end

  def create
    @creator = Creator.new(creator_params)

    respond_to do |format|
      if @creator.save
        format.json { render json: @creator, status: :created, location: @creator }
      else
        format.json { render json: @creator.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @creator = Creator.find(params[:id])

    respond_to do |format|
      if @creator.update_attributes(creator_params)
        format.json { render json: @creator, location: @creator }
      else
        format.json { render json: @creator.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @creator = Creator.find_unarchived(params[:id])
    @creator.archive
    head status: :no_content
  end

  def creator_params
    params.require(:creator).permit(:name, :role, :archived)
  end
end
