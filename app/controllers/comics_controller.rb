class ComicsController < ApplicationController
  def index
    if params[:variant]
      @comics = Comic.variant.order('id asc')
    elsif params[:reprint]
      @comics = Comic.reprint.order('id asc')
    else
      @comics = Comic.all.order('id asc')
    end
  end

  def show
    @comic = Comic.find(params[:id])
  end

  def create
    @comic = Comic.new(comic_params)

    respond_to do |format|
      if @comic.save
        format.json { render json: @comic, status: :created, location: @comic }
      else
        format.json { render json: @comic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @comic = Comic.find(params[:id])

    respond_to do |format|
      if @comic.update_attributes(comic_params)
        format.json { render json: @comic, location: @comic }
      else
        format.json { render json: @comic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comic = Comic.find(params[:id])
    @comic.archive
    head status: :no_content
  end

  def comic_params
    params.require(:comic).permit(:title, :price, :image_id, :comic_series_id,
                                  :publisher_id, :release_date, :variant, :reprint)
  end
end