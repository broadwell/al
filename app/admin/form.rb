ActiveAdmin.register Form do

	menu parent: "Categories"
	config.sort_order = 'name_asc'
	
	index do
		column 'form_id', :id
		column 'name', :name 
	end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
