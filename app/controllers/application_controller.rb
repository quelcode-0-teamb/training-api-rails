class ApplicationController < ActionController::API
  rescue_from StandardError, with: :error500
  rescue_from ActiveRecord::RecordNotFound, with: :error404
  rescue_from ActiveRecord::RecordInvalid, with: :error422
  rescue_from ActiveRecord::RecordNotSaved, with: :error422
  rescue_from ActionController::ParameterMissing, with: :error422
  rescue_from ActionController::BadRequest, with: :error400

  def authorize!
    return if current_user

    render json: { messages: ['tokenが違います'] }, status: :unauthorized
  end

  def current_user
    @current_user ||= User.where(token: bearer_token).first
  end

  private

  def check_params_present(update_params)
    @params_array = {}
    update_params.each do |key, value|
      @params_array[key] = value if value.present?
    end
  end

  def bearer_token
    @bearer_token ||= begin
      pattern = /^Bearer /
      header = request.headers['Authorization']
      header.gsub(pattern, '') if header&.match(pattern)
    end
  end

  def error404(err)
    render status: :not_found, json: {
      error: {
        messages: [err.message],
        status: 404
      }
    }
  end

  def error500
    render status: :internal_server_error, json: {
      error: {
        messages: ['Internal Server Error'],
        status: 500
      }
    }
  end

  def error400(err)
    render status: :bad_request, json: {
      error: {
        messages: [err.message],
        status: 400
      }
    }
  end

  def error422(err)
    render status: :unprocessable_entity, json: {
      error: {
        messages: [err.message],
        status: 422
      }
    }
  end
end
