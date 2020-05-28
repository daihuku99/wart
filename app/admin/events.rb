ActiveAdmin.register Event do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :detail, :event_type, :start_date, :end_date, :user_id, :exhibition_id, :art_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :detail, :event_type, :start_date, :end_date, :user_id, :exhibition_id, :art_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :title, :detail
end
