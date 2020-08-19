RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.parent_controller = 'ApplicationController' 
  config.authorize_with :cancancan
  config.main_app_name = Proc.new { |controller| [ "VNIUERSITATIS", "Back Office" ] }
  config.actions do
    dashboard do                  # mandatory
      statistics false
    end
    index                         # mandatory
    new
    export
    # bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Course' do
    create do
      include_all_fields # all other default fields will be added after, conveniently
      exclude_fields :created_at, :update_at, :slug
    end

    edit do
      include_all_fields
      exclude_fields :created_at, :update_at
      field :teacher do
        inline_add false
        inline_edit false
        associated_collection_scope do
          Proc.new { |scope|
            scope = scope.where(user_type: 'teacher') 
          }
        end
      end
      field :slug do
        read_only true
      end
    end
  end

  config.model 'User' do
    object_label_method do
      :user_email_id
    end

    edit do
      include_all_fields
      field :user_type, :enum do
        enum do
          User.user_types
        end
      end
      exclude_fields :password, :password_confirmation, :created_at, :update_at
    end
  end
end
