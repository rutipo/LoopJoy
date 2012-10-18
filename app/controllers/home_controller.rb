class HomeController < ApplicationController
	layout false, :only => :index

	def index
	end

	def eula
		if params[:accept] == "true"
			flash[:success] = 'Thanks for registering with LoopJoy'
			redirect_to root_path
		elsif params[:accept] == "false" 
			params.delete :accept
			flash[:notice] = nil
			flash[:error] = 'You Must Accept End User Licensce Agreement'
		else
			flash[:notice] = 'Please Read and Accept End User Licensce Agreement'
		end
	end
end
