class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :opinion
      t.references :user, index: true
      
      t.timestamps
    end
  end
end