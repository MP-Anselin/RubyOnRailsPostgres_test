class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true, name: 'unique_emails' }
      t.string :password_hash
      t.timestamps
    end
  end
end
