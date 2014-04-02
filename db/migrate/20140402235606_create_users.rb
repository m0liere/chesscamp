class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :instructor_id
      t.string :username
      t.string :password_digest
      t.string :role
      t.boolean :active

      t.timestamps
    end
  end
end
