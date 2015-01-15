class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :country
      t.date :birthday
      t.string :sex
      t.text :about
      t.timestamps
    end
  end
end
