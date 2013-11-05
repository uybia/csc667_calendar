class AppointmentController < ApplicationController

 skip_before_filter  :verify_authenticity_token

 def index
   @appointment = Appointment.where("month = ? AND year= ?", params[:month], params[:year])
   render :json => @appointment.as_json
 end

 def create
   @appointment = Appointment.new(app_params)
   @appointment.save
   render :nothing => true
 end

 private

 def app_params
   params.require(:appointment).permit(:event, :time, :month, :day, :year)
 end
end
