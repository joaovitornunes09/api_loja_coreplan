class ApplicationController < ActionController::API
    def encode_token(payload)
        JWT.encode(payload, "g213yjg1yu3g")
    end

    def decode_token
        auth_header = request.headers['Authorization']

        if auth_header
            token = auth_header.split(' ').last

            begin
                JWT.decode(token, "g213yjg1yu3g", true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil            
            end
        end
    end

    def authorized_user
        decoded_token = decode_token()

        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def authorize
        render json: {message: 'Você precisa estar logado'}, status: :unauthorized unless authorized_user
    end

    def needsAdminUser
        render json: {status: false, message: 'Você precisa ser admin para acessar essa função.'}, status: :unauthorized unless authorized_user.user_type_id == 1
    end

    def calculate_discounted_value(price, discount_percent)
        discounted_value = price - (price * discount_percent / 100)
        discounted_value.round(2)
    end
end
