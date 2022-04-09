class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :age
      t.string :first_name, default: 'test', null: false
      t.timestamps
    end

    add_index :users, :first_name, unique: true
    add_index :users, [:first_name, :age]
  end
end
