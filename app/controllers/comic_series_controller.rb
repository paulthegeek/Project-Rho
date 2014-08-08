class ComicSeriesController < ApplicationController
  def index
    @comic_series = ComicSeries.all
    @cs_no_id = ComicSeries.has_no_sub_id
  end

  def new
    @single_comic_series = ComicSeries.new
  end

  def create
    @single_comic_series = ComicSeries.new(comic_series_params)

    respond_to do |format|
      if @single_comic_series.save
        format.html { redirect_to comic_series_index_path, notice: 'Comic Series Created' }
      else
        flash[:error] = @single_comic_series.errors
        format.html { render action: :new }
      end
    end 
  end

  def edit
    @single_comic_series = ComicSeries.find(params[:id])
  end

  def update
    @comic_series = ComicSeries.find(params[:id])

    respond_to do |format|
      if @comic_series.update_attributes(comic_series_params)
        format.html { redirect_to comic_series_index_path, notice: 'comic_series Updated' }
      else
        flash[:error] = @comic_series.errors
        format.html { render action: :edit }
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