class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        #log in button
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = "Invalid credentials fool"
            render :new
        end
    end

    #no idea??
    def destroy
        session[:session_token] = nil
        if current_user
            current_user.reset_session_token!
        end
        @current_user = nil
        redirect_to new_session_url
    end
end
