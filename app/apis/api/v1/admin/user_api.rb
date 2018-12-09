module API
  module V1
    module Admin
      class UserAPI < Grape::API
        helpers Helper::SharedParams

        resource 'admin/users' do
          before { authenticate_user! }

          desc 'Get users' do
            success Entity::V1::PaginatedUser
          end
          params do
            use :pagination
          end
          get do
            authorize User, :index?, policy_class: ::Admin::UserPolicy

            users = User.order(id: :asc)
            paginate users, with: Entity::V1::PaginatedUser
          end

          desc 'Promote user to admin' do
            detail 'Only owner user can do this action.'
            success Entity::V1::User
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
