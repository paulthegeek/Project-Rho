class ComicSeriesController < ApplicationController
  def index
    if params[:no_sub_id]
      @comic_series = ComicSeries.has_no_sub_id
    else
      @comic_series = ComicSeries.all.order('id asc')
    end
  end

  def show
    @single_comic_series = ComicSeries.find(params[:id])
  end

  def create
    @single_comic_series = ComicSeries.new(comic_series_params)

    respond_to do |format|
      if @single_comic_series.save
        format.json { render json: @single_comic_series, status: :created, location: @single_comic_series }
      else
        format.json { render json: @single_comic_series.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @single_comic_series = ComicSeries.find(params[:id])

    respond_to do |format|
      if @single_comic_series.update_attributes(comic_series_params)
        format.json { render json: @single_comic_series, location: @single_comic_series }
      else
        format.json { render json: @single_comic_series.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @single_comic_series = ComicSeries.find(params[:id])
    @single_comic_series.archive
    head status: :no_content
  end

  def comic_series_params
    params.require(:comic_series).permit(:name, :sub_id)
  end
end
