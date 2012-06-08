class AddLoginToUser < ActiveRecord::Migration
  def self.up
    down
    add_column :users, :login, :string
    User.reset_column_information
     User.all.each do|t|
      t.update_attribute :login, t.last_name
    end
  end
  def self.down
    remove_column :users , :login
  end
end
