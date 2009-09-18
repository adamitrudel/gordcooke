class Remote::EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  no_login_required

  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.json {
        render :text => @event.to_json
      }
    end
  end
end