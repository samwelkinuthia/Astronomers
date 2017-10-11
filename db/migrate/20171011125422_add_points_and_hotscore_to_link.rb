class AddPointsAndHotscoreToLink < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :points, :integer
    add_column :links, :hot_score, :float
  end
end
