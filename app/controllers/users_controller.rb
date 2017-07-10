class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_action :authorize, only: [:grant, :revoke]

  def login
    user = User.find_by(name: params[:name])
    if user.present?
      login_user(user)
      msg = "Welcome Back"
    else
      msg = "User does not exit!"
    end
    redirect_to root_path, notice: msg
  end

  def role(role_type='USER')
    role_id = Role.find_by(name: role_type)
    if role_id
      user_role = UserRole.new
      user_role.role_id = role_id
      user_role.user_id = current_user.id
      user_role.save
    end
  end

  def logout
    session[:current_user_id] = nil
    redirect_to root_path, notice: "Logging Out!"
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def grant
    role_id = Role.find_by(:name => params[:role]).id rescue nil
    format.json { render json: {:msg => "Role not found!"}, status: :not_found and return } if role_id.nil? 

    user_role = UserRole.new
    user_role.user_id = params[:user_id]
    user_role.role_id = role_id
    respond_to do |format|
      if user_role.save
        format.json { render json: { :msg => 'User role added successfully.' }, status: :ok }
      else
        format.json { render json: user_role.errors, status: :unprocessable_entity } 
      end
    end
  end

  def revoke
    role_id = Role.find_by(:name => params[:role])
    format.json { render json: {:msg => "Role not found!"}, status: :not_found and return } if role_id.nil? 

    user_role = UserRole.where(:user_id => params[:user_id]).where(:role_id => role_id)
    respond_to do |format|
      if user_role.delete_all
        format.json { render json: {:msg => "Role deleted successfully"}, :status => :ok }
      else
        format.json { render json: user_role.errors, status: :unprocessable_entity } 
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name)
    end
end
