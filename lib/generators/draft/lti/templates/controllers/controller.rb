class <%= plural_table_name.camelize %>Controller < ApplicationController
  before_action :set_<%= singular_table_name.underscore %>, only: %i[show edit update destroy]

  # GET /<%= plural_table_name %>
  def index
    @<%= plural_table_name.underscore %> = <%= class_name.singularize %>.all
  end

  # GET /<%= plural_table_name %>/1
  def show; end

  # GET /<%= plural_table_name %>/new
  def new
    @<%= singular_table_name.underscore %> = <%= class_name.singularize %>.new
  end

  # GET /<%= plural_table_name %>/1/edit
  def edit; end

  # POST /<%= plural_table_name %>
  def create
    @<%= singular_table_name.underscore %> = <%= class_name.singularize %>.new(<%= class_name.singularize %>_params)

    if @<%= singular_table_name.underscore %>.save
      redirect_to @<%= singular_table_name.underscore %>, notice: "<%= class_name.singularize %> was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /<%= plural_table_name %>/1
  def update
    if @<%= singular_table_name.underscore %>.update(<%= class_name.singularize %>_params)
      redirect_to @<%= singular_table_name.underscore %>, notice: "<%= singular_table_name.capitalize %> was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /<%= plural_table_name %>/1
  def destroy
    @<%= singular_table_name.underscore %>.destroy
    redirect_to <%= plural_table_name.underscore %>_url, notice: "<%= class_name.singularize %> was successfully destroyed."
  end

  <% if class_name.singularize == "Resource" -%>
  def teacher_backdoor
    @user = User.find_by(
      # from dev:prime data
      id_from_tc: "bd815e718b9d924bdd6ceb708bc2c6eb4ab0754b",
    )
    set_back_door_attributes

    redirect_to resource_url(@resource)
  end

  def student_backdoor
    @user = User.find_by(
      # from dev:prime data
      id_from_tc: "03bdb94e0a8fc857ef71280eaf0919199a841bc0",
    )
    set_back_door_attributes

    redirect_to resource_url(@resource)
  end
  <% end %>
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_<%= singular_table_name.underscore %>
    @<%= singular_table_name.underscore %> = <%= class_name.singularize %>.find(params[:id])
  end

  <% if class_name.singularize == "Resource" %>
  def set_back_door_attributes
    reset_session
    # from seed data
    @context = Context.find_by(
      # from seed data
      id_from_tc: "4a91e348a7026222b98bd2af87be0aeee085eb0f",
    )
    # from seed data
    @resource = Resource.find_by(
      # from seed data
      id_from_tc: "fa070692257fc1b67ce7461e18cecd418a5286d5",
    )
    @enrollment = Enrollment.find_by(context: @context, user: @user)

    @submission = Submission.find_by(
      enrollment: @enrollment,
      resource: @resource,
    )

    session[:enrollment_id] = @enrollment.id
    session[:launch_id] = @enrollment.launches.last.id
    session[:resource_id] = @resource.id
    session[:submission_id] = @submission.try(:id)
  end
  <% end %>

end
