class PlacerefsController < ApplicationController

  def index
    placerefs = Placeref.all.for_popup

    if params[:id]
      placerefs = placerefs.where(:placeref_id => params[:id])
    end

    if params[:place_id]
      placerefs = placerefs.by_place(params[:place_id])
    end

    if params[:place_id] && params[:author_id]
      placerefs = placerefs.by_place_and_author(params[:place_id],params[:author_id])
    end

    @placerefs = placerefs

  end

end
