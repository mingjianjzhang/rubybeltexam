class Borrower < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :purpose, :description, :money, presence: true,  on: :create
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX },  on: :create
  validates :password, length: { minimum: 8 },  on: :create  
  validates :password_confirmation, presence: true ,  on: :create
  has_secure_password
  has_many :transactions
  has_many :lenders, through: :transactions

  def receive_money amount_given
  	update(raised: raised+amount_given.to_i)
  end
  def doesnt_need_that_much requested_amount
  	raised + requested_amount.to_i > money
  end


end
 