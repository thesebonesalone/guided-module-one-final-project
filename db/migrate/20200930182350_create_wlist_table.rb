class CreateWlistTable < ActiveRecord::Migration[5.0]
  def change
    create_table :wlists do |t|
      t.belongs_to :game
      t.belongs_to :user
    end
  end
end