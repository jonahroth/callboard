class Users::RegistrationsController < Devise::RegistrationsController
  after_action :create_person_and_production, only: :create

  def create
    super
  end

  protected

  def create_person_and_production
    production = Production.create!(title: params[:production_title])
    person = production.people.create!(first: params[:first], last: params[:last], email: @user.email, cell: params[:cell])
    @user.person = person
    @user.save!
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:production_title, :first, :last])
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
