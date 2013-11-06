class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :confirm_password
      t.string :chat_url

      t.timestamps
    end
  end
end
