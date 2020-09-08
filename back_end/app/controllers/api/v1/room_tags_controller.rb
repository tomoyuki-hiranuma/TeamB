'''
  Author: Kyosuke Yokota
  Date: 20200904
'''

module Api
    module V1
        class RoomTagsController < ApplicationController
            include JwtAuthenticator
            jwt_authenticate

            def create
                room_tag = RoomsTag.new(room_tag_params)
                if room_tag.save
                    render json: { status: 'SUCCESS', data: { room_tag: room_tag } }
                  else
                    render json: { status: 'ERROR', data: { error: room_tag.errors } }
                end
            end

            def room_tag_params
                params.require(:room_tag).permit(:tag_id, :room_id)
            end
        end
    end
end

