# frozen_string_literal: true

module User
  class UserController < ApplicationController
    before_action :set_user, only: %i[edit update]

    def account
      case params[:user][:account_type].to_s
      when 'login'
        if params[:user][:password].nil?
          result = { type: 'error', status: 401, message: ['email or password cannot empty.'] }
        else
          user = User.find_for_authentication(email: params[:user][:email])
          if user.nil?
            result = { type: 'error', status: 401, message: ['Your email or password were incorrect.'] }
          elsif user.valid_password?(sign_in_params[:password])
            sign_in :user, user
            result = { type: 'success', status: 200, message: 'You are Successfully Sign in.', data: user }
          else
            result = { type: 'error', status: 401, message: ['Your email or password were incorrect.'] }
          end
        end
        render json: result
        nil
      when 'signup'
        user = User.find_by_email(create_params[:email])
        if user.nil?
          # Create new user
          user = User.new(create_params)
          return user_error(status: 422, errors: user.errors.full_messages) unless user.valid?

          user.save!
          sign_in :user, user
          # return user object as response
          result = { type: 'success', status: 201, data: user,
                     message: ['Welcome! You have signed up successfully.'] }
        else
          result = { type: 'error', status: 409, message: ['Email is already taken.'] }
        end

        render json: result
        nil

      when 'forgot'
        if params[:user][:email].blank?
          return render json: { type: 'error', status: 401, message: ['Email cannot Empty.'] }
        end

        user = User.find_by_email(params[:user][:email])

        if user.present?
          # SEND EMAIL HERE
          user.send_reset_password_instructions
          render json: { type: 'success', status: 213,
                         message: ['You will receive an email with instructions for reset password'] }
        else
          render json: { type: 'error', status: 206, message: ['Email address not found.'] }
        end
      end
    end

    def user_error(status: 500, errors: [])
      puts errors.full_messages if !Rails.env.production? && (errors.respond_to? :full_messages)
      head status: status and return if errors.empty?

      render json: { type: 'error', status: status, message: errors }, status: status
    end

    def logout
      if user_signed_in?
        sign_out current_user
        result = { type: 'success', status: 200, message: ['Signed out successfully.'] }
      end

      render json: result
      nil
    end

    def index
      @users = User.where.not(u_type: 'super')
      @s = params[:q].to_s.strip

      unless params[:q].nil?
        @users = @users.where('lower(name) LIKE ? OR lower(email) LIKE ?', "%#{@s.downcase}%", "%#{@s.downcase}%")
      end
      @users = @users.paginate(page: params[:page], per_page: 25).order('created_at asc')
    end

    def admin_user
      @users = User.where(u_type: 'admin')
      @s = params[:q].to_s.strip

      unless params[:q].nil?
        @users = @users.where('lower(name) LIKE ? OR lower(email) LIKE ?', "%#{@s.downcase}%", "%#{@s.downcase}%")
      end
      @users = @users.paginate(page: params[:page], per_page: 25).order('created_at asc')
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          format.html { redirect_to user_index_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit; end

    def update
      if user_params[:password] == '' && user_params[:password_confirmation] == ''
        params[:user].delete :password
        params[:user].delete :password_confirmation
      end
      respond_to do |format|
        if @user.update(user_params)

          format.html { redirect_to user_index_path, notice: 'User was updated successfully.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render action: :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def create_params
      params.require(:user).permit(:name, :mobile, :email, :password, :password_confirmation)
    end

    def user_params
      p = params.require(:user).permit(:name, :mobile, :email, :password, :password_confirmation, :u_type,
                                       all_location: [], permission: [])
      if p[:u_type] == 'other'
        p[:permission] = []
        p[:all_location] = []
      end
      p[:all_location] = [] if p[:all_location].nil?
      p
    end

    def set_user
      @user = User.find(params[:id])
    end

    def sign_in_params
      params.require(:user).permit(:email, :password).delete_if { |_k, v| v.nil? }
    end
  end
end
