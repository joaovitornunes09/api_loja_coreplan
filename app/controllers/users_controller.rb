class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_parse_error
  rescue_from ActiveRecord::NotNullViolation, with: :handle_parse_error

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: {
      status: true,
      message: "Requisição realizada com sucesso" ,
      data: {
        id: @user.id , username: @user.username, role: @user.user_type_id
      }
  }, status: :ok
  end

  # POST /users
  def create
      @user = User.create(user_params)

      if @user.valid?
          token = encode_token({user_id: @user.id})
          render json: {user: @user, token: token}, 
          status: :ok
      else
          render json: {error: "Usuario ou senha inválidos"}, 
          status: :unprocessable_entity
      end
  end

  def login 
      @user = User.find_by(username: user_params[:username])

      if @user && @user.authenticate(user_params[:password])
          token = encode_token({user_id: @user.id})
          render json: {
              status: true,
              message: "Requisição realizada com sucesso" ,
              data: {
                user: {id: @user.id , username: @user.username, role: @user.user_type_id}, 
                token: token
              }
          }, status: :ok
      else 
          render json: {
              status: false,
              message: "Erro ao realizar requisição" ,
              error: "Usuario ou senha inválidos"
          }, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
        params.permit(:username, :password).merge(user_type_id: 2)
    end

    def handle_parse_error(exception)
      render json: { status: 400, message: "Erro ao realizar requisição", data: "Usuário ou senha inválido."}, status: :bad_request
    end
end
