class Lender < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :money, presence: true, on: :create
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }, on: :create
  validates :password, length: { minimum: 8 }, on: :create
  validates :password_confirmation, presence: true, on: :create 	
  has_secure_password
  has_many :transactions, dependent: :destroy
  has_many :borrowers, through: :transactions

  
  def self.my_lenders borrower_id
  	self.joins(:transactions).where("borrower_id = #{borrower_id}").group("lenders.id").select("first_name || ' ' || last_name as full_name, email, SUM(amount) as amount_lent")
  end
  def has_enough_money requested_amount
    money >= requested_amount.to_i
  end

  def give_money requested_amount 
    update(money: money - requested_amount.to_i)
  end
end
 