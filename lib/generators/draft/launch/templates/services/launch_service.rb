class LaunchService
  require "oauth/request_proxy/action_controller_request"

  attr_accessor :context
  attr_accessor :credential
  attr_accessor :enrollment
  attr_accessor :launch
  attr_accessor :payload
  attr_accessor :request
  attr_accessor :resource
  attr_accessor :submission
  attr_accessor :tool_consumer
  attr_accessor :user

  def initialize(request, request_params)
    @request = request
    @payload = request_params
  end

  def authenticate_launch
    self.launch = Launch.create(payload: payload)
    find_credential

    unless credential.enabled?
      raise "Credential disabled"
    end

    tool_provider = credential.create_tool_provider(payload)
    tool_provider.valid_request?(request)
  end

  def create_graph
    find_or_create_graph
    update_launch_associations
  end

  private

  def find_credential
    self.credential = Credential.find_by(
      consumer_key: payload.fetch(:oauth_consumer_key),
    )
    if credential.blank?
      raise "Unknown LTI Key"
    end

    credential
  end

  def find_or_create_tool_consumer
    self.tool_consumer = ToolConsumer.find_or_create_by(
      instance_guid: payload[:tool_consumer_instance_guid],
    ) do |tc|
      tc.instance_url = payload[:tool_consumer_instance_url]
      tc.instance_description = payload[:tool_consumer_instance_description]
      tc.instance_contact_email = payload[:tool_consumer_instance_contact_email]
      tc.instance_name = payload[:tool_consumer_instance_name]
    end

    unless credential.in?(tool_consumer.credentials)
      tool_consumer.credentials << credential
    end

    tool_consumer
  end

  def find_or_sign_up_user
    self.user = User.find_or_create_by(id_from_tc: payload[:user_id]) do |user|
      user.first_name = payload[:lis_person_name_given]
      user.last_name = payload[:lis_person_name_family]
      user.preferred_name = payload[:lis_person_name_given]
    end
    user
  end

  def find_or_create_context
    self.context = Context.find_or_create_by(
      id_from_tc: payload[:context_id],
    ) do |context|
      context.title = payload[:context_title]
    end
    context
  end

  def find_or_create_resource
    self.resource = Resource.find_or_create_by(
      id_from_tc: payload[:resource_link_id],
    ) do |resource|
      resource.title = payload[:resource_link_title]
      resource.context = @context
    end
    resource
  end

  def find_or_create_enrollment
    self.enrollment = Enrollment.find_or_create_by(
      context: context,
      user: user,
    ) do |enrollment|
      enrollment.roles = payload[:roles]
    end
  end

  def find_or_create_submission
    self.submission = Submission.find_or_create_by(
      resource: resource,
      enrollment: enrollment,
    )
  end

  def find_or_create_graph
    find_or_create_tool_consumer
    find_or_sign_up_user
    find_or_create_context
    find_or_create_resource
    find_or_create_enrollment
    find_or_create_submission
  end

  def update_launch_associations
    launch.update_attributes(
      context: context,
      resource: resource,
      enrollment: enrollment,
      user: user,
      tool_consumer: tool_consumer,
    )
  end
end
