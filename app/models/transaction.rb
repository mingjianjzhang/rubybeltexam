class Transaction < ActiveRecord::Base
  belongs_to :lender
  belongs_to :borrower

  def self.my_loans id
  	self.joins(:borrower).select("first_name || ' ' || last_name as full_name, purpose, description, money, raised, SUM(amount) as amount_lent, transactions.id as trans_id, borrowers.id as borrower_id").where(lender_id: id).group("borrowers.id")
  end




end
 