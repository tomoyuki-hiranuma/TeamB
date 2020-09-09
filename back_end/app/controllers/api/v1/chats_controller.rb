module Api
    module V1
        class ChatsController < ApplicationController            #rikuiwasaki
            jwt_authenticate

            def index
                if chats = Chat.where(room_id: @current_user.room_id).order(updated_at: :desc)
                    render json: { status: 'SUCCESS',data: {
                    chats: chats } }
                else
                    render status:500, json: { status: 'ERROR', data:{ error: "情報を取得できませんでした。"}}
            end
            def create
                chat_info=chat_params
                chat_info[:user_id] = @current_user.id
                @new_chat=Chat.new(chat_info)
                if @new_chat.save
                    RoomChannel.broadcast_to("room_#{chat_info[:room_id]}",@new_chat)
                    render status:201, json: { status: 'SUCCESS', data: { chat: @new_chat } }
                else 
                    render status:500, json: { status: 'ERROR', data: { error: "情報を取得できませんでした" }}
                end
            end
            def update
                chat = Chat.find(params[:id])
                if chat.user_id == @current_user.id
                    if updated_chat=Chat.update(chat_params)
                        render status:201 json: { status: 'SUCCESS', data: {chat: updated_chat}}
                    else
                        render status:500 json: { status: 'ERROR', data: { errors: "情報を取得できませんでした。"}}
                    end
                else
                    render status:401, json: {status: 'ERROR', data:{erros: "invalid user"}}
                end
            
            end
            private
                def set_chat
                    @chat=Chat.find(params[:id])
                end
                def chat_params
                    params.require(:chat).permit(:text,:room_id)
                end
        #rikuiwasaki
        end
    end
end
