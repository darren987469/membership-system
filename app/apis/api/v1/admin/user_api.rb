module API
  module V1
    module Admin
      class UserAPI < Grape::API
        helpers Helper::SharedParams

        resource 'admin/users' do
          before { authenticate_user! }

          params do
            use :pagination
          end
          get do
            authorize User, :index?, policy_class: ::Admin::UserPolicy

            users = User.all
            paginate users, with: Entity::V1::PaginatedUser
          end

          patch ':id/promote_to_admin' do
            user = User.find(params[:id])
            authorize user, :promote_admin?, policy_class: ::Admin::UserPolicy

            user.update(role: :admin)
            present user, with: Entity::V1::User
          end
        end
      end
    end
  end
end
