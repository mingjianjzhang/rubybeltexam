class AddColsToBorrower < ActiveRecord::Migration
  def change
  	add_column :borrowers, :purpose, :string
  	add_column :borrowers, :description, :text
  	add_column :borrowers, :raised, :integer
  end
end
