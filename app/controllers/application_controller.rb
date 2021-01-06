class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
  rescue_from ActionController::ParameterMissing,  with: :render_parameter_missing


  private

  def render_not_found(exception)
    logger.info { exception } # for logging
    render json: { error: exception }, status: :not_found
  end

  def render_record_invalid(exception)
    logger.info { exception } # for logging
    render json: { errors: exception.record.errors.as_json }, status: :bad_request
  end

  def render_parameter_missing(exception)
    logger.info { exception } # for logging
    render json: { error: 'missing required parameters.'}, status: :unprocessable_entity
  end

end
