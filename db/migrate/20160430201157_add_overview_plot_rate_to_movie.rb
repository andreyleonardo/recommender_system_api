class AddOverviewPlotRateToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :overview, :string
    add_column :movies, :plot, :string
    add_column :movies, :rate, :string
  end
end
