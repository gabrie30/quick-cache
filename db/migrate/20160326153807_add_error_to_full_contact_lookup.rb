class AddErrorToFullContactLookup < ActiveRecord::Migration
  def change
    add_column :full_contact_lookups, :error, :text
  end
end
