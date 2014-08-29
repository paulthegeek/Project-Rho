class ComicSeriesController < ApplicationController
  def index
    @comic_series = ComicSeries.all.order('id asc')
    @cs_no_id = ComicSeries.has_no_sub_id
  end

  def show
    @single_comic_series = ComicSeries.find(params[:id])
  end

  def create
    @single_comic_series = ComicSeries.new(comic_series_params)

    respond_to do |format|
      if @single_comic_series.save
        format.json { render json: @single_comic_series }
      else
        format.json { render json: @single_comic_series.errors }
      end
    end
  end

  def update
    @single_comic_series = ComicSeries.find(params[:id])

    respond_to do |format|
      if @single_comic_series.update_attributes(comic_series_params)
        format.json { render json: @single_comic_series }
      else
        format.json { render json: @single_comic_series.errors }
      end
    end
  end

  def destroy
    @comic_series = ComicSeries.find(params[:id])
    @comic_series.destroy

    respond_to do |format|
      format.html { redirect_to comic_series_index_path}
    end
  end

  def comic_series_params
    params.require(:comic_series).permit(:name, :sub_id)
  end
end
