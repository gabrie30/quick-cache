class CreateFullContactLookups < ActiveRecord::Migration
  def change
    create_table :full_contact_lookups do |t|
      t.string :email, null: false
      t.text :data

      t.timestamps null: false
    end
  end
end
