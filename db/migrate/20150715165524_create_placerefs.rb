# placeref = reference in text to a place
# fk place_id --> place.place_id
class CreatePlacerefs < ActiveRecord::Migration
  def change
    create_table :placerefs do |t|
    	t.integer :placeref_id
      t.integer :work_id
      t.string :passage_id # was placerefs.source_loc
    	t.string :prefname # may be altered from original
      t.string :author_id
    	t.integer :place_id
      t.text :geom_wkt
      t.string :placeref_type
     	t.timestamps null: false
    end
  end
end
