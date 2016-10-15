class SessionsController < ApplicationController
  def index
  end

  def login

  end

  def login_user
  	if Borrower.find_by(email: params[:email])
  	  borrower = Borrower.find_by(email: params[:email])
  	  if borrower.authenticate(params[:password])
  	    session[:user_id] = borrower.id
  	    redirect_to "/borrower/#{borrower.id}"
  	  else
  	    flash[:bad_password] = "Invalid password"
  	    redirect_to :back
  	  end
  	elsif Lender.find_by(email: params[:email])
  	  lender = Lender.find_by(email: params[:email])
  	  if lender.authenticate(params[:password])
  	    session[:user_id] = lender.id
  	    redirect_to "/lender/#{lender.id}"
  	  else
  	    flash[:bad_password] = "Invalid password"
  	    redirect_to :back
  	  end
  	else
  	  flash[:no_user] = "As far as we're concerned, you don't exist. Please register to the left"
  	  redirect_to :back
  	end 	
  end
  def logout
  	reset_session
  	redirect_to :root
  end
end
 