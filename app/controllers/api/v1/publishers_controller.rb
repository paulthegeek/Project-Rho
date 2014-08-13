module Api
   module V1
    class PublishersController < ApplicationController
      respond_to :json
      def index
        @publishers = Publisher.all.order(id: :asc)
      end
    end
  end
end
