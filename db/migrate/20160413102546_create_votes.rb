class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :joke, index: true, foreign_key: true
      t.string :user
      t.integer :vote
      t.date :voted_on

      t.timestamps null: false
    end
  end
end
