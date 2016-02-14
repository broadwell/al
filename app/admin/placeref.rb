ActiveAdmin.register Placeref do
  permit_params :placeref_id, :placeref, :placeref_type, :place_id

  config.sort_order = 'placeref'

  index do
    column 'id', :placeref_id
    column 'place reference', :placeref
    column 'type', :placeref_type
    column 'place_id', :place_id

    actions
  end

end