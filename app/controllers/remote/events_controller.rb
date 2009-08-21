class Remote::EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.json {
        render :text => @event.to_json
      }
    end
  end
end