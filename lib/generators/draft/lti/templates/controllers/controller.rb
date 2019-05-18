class <%= plural_table_name.camelize %>Controller < ApplicationController
  before_action <%= singular_table_name.underscore.to_sym %>, only: %i[show edit update destroy]

  # GET /<%= plural_table_name %>
  def index
    @users = User.all
  end

  # GET /<%= plural_table_name %>/1
  def show; end

  # GET /<%= plural_table_name %>/new
  def new
    @user = User.new
  end

  # GET /<%= plural_table_name %>/1/edit
  def edit; end

  # POST /<%= plural_table_name %>
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /<%= plural_table_name %>/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /<%= plural_table_name %>/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: "User was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def @set_<%= singular_table_name.underscore %>
    @<%= singular_table_name.underscore %> = <%= class_name.singularize %>.find(params[:id])
  end

end