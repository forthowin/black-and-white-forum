class RemoveBodyFromSubjects < ActiveRecord::Migration
  def change
    remove_column :subjects, :body
  end
end
