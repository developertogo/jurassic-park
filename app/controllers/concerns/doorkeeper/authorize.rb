# frozen_string_literal: true

module Doorkeeper
  module Authorize
    extend ActiveSupport::Concern

    included do
      before_action :find_doorkeeper_application!

      attr_reader :current_doorkeeper_application
    end

    private

    def find_doorkeeper_application!
      params[:client_id] = request.headers[:HTTP_CLIENT_ID] if request.headers.key?(:HTTP_CLIENT_ID)
      params[:client_secret] = request.headers[:HTTP_CLIENT_SECRET] if request.headers.key?(:HTTP_CLIENT_SECRET)

      @current_doorkeeper_application = Doorkeeper::Application.find_by(uid: params[:client_id],
                                                                        secret: params[:client_secret])

      render json: invalid_client_response, status: :unauthorized if @current_doorkeeper_application.blank?
    end

    def invalid_client_response
      { errors: [I18n.t('doorkeeper.errors.messages.invalid_client')] }
    end
  end
end
