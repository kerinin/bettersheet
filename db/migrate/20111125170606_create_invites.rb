class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :referrer
      t.string :email
      t.date :date

      t.timestamps
    end
  end
end
