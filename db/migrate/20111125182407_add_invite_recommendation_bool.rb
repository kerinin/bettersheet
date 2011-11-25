class AddInviteRecommendationBool < ActiveRecord::Migration
  def up
    add_column :invites, :recommendation, :boolean, :default => false
  end

  def down
    remove_column :invites, :recommendation
  end
end
