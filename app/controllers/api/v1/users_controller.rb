module Api
  module V1
    class UsersController < BaseController
      def exists?
        display_name = params[:displayName]
        email = params[:email]
        search_hash = {}
        if display_name
          @success = true
          search_hash[:display_name] = display_name
        elsif email
          @success = true
          search_hash[:email] = email
        else
          @success = false
          return render :exists
        end

        @user = User.find_by(search_hash)
        render :exists
      end
    end
  end
end