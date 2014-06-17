class PublishersController < ApplicationController
  
  def index
    @publishers = Publisher.all.order('name asc')
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
        format.html { redirect_to publishers_path, notice: 'Publisher Updated' }
      else
        flash[:error] = @publisher.errors
        format.html { render action: :edit }
      end
    end
  end

  def create
    @publisher = Publisher.new(publisher_params)

    respond_to do |format|
      if @publisher.save
        format.html { redirect_to publishers_path, notice: 'Publisher Created' }
      else
        flash[:error] = @publisher.errors
        format.html { render action: :new }
      end
    end
  end

  def publisher_params
    params.require(:publisher).permit(:name)
  end
end