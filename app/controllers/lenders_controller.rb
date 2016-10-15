class LendersController < ApplicationController
  def index
  end

  def create
  	lender = Lender.create(lender_params)
  	if lender.save
  	  session[:user_id] = lender.id
  	  redirect_to "/lender/#{lender.id}"
  	else 
  	  flash[:lender_errors] = lender.errors.full_messages
  	  redirect_to :back
  	end
  end

  def new_transaction
  	lender = Lender.find(params[:transaction][:lender_id])
  	if lender.money == 0 
  	  flash[:error] = "You don't have any money, so you can't make any loans"
  	  redirect_to :back
  	elsif lender.has_enough_money(params[:transaction][:amount])
      borrower = Borrower.find(params[:transaction][:borrower_id])
      if borrower.doesnt_need_that_much(params[:transaction][:amount])
      	flash[:error] = "The person you were trying to lend to doesn't need that much money."
      	redirect_to :back
      else
        Transaction.create(transaction_params)
        borrower.receive_money(params[:transaction][:amount])
        lender.give_money(params[:transaction][:amount])
        redirect_to :back
      end
    else 
      flash[:error] = "You tried to make a loan for which you didn't have enough money ... be careful"
      redirect_to :back
    end
  end

  def show
  	@lender = Lender.find(params[:id])
  	@in_need = Borrower.all
  	@my_loans = Transaction.my_loans(params[:id])
  end

  private 
  def lender_params
  	params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
  end
  def transaction_params
    params.require(:transaction).permit(:lender_id, :borrower_id, :amount)	
  end
end
 