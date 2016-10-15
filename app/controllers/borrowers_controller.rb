class BorrowersController < ApplicationController
  def index
  end

  def create
  	borrower = Borrower.create(borrower_params)
  	if borrower.save
  	  session[:user_id] = borrower.id
  	  redirect_to "/borrower/#{borrower.id}"
  	else 
  	  flash[:borrower_errors] = borrower.errors.full_messages
  	  redirect_to :back
  	end
  end

  def show
  	@borrower = Borrower.find(params[:id])
  	@my_lenders = Lender.my_lenders(@borrower.id)

  end

  def new_transaction

  end
  private
  def borrower_params
  	params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money, :purpose, :description, :raised)
  end
  def transaction_params
  	params.require(:transaction).permit(:id, :lender_id, :borrower_id, :amount)
  end
end
 