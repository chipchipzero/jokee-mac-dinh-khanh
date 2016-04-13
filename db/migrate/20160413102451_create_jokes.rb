class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.text :content

      t.timestamps null: false
    end
  end
end
