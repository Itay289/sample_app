class SessionsController < ApplicationController

	def new
		
	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			if params[:session][:remember_me] 
				sign_in user
			else
        cookies[:remember_token] = user.remember_token
      end  
      redirect_back_or user  
		else	
			flash.now[:error] = "invalid email/password combination"
			render 'new'
		end	
	end

	def destroy
		sign_out
		redirect_to root_path
	end
end
