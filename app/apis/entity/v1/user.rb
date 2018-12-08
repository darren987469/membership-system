module Entity
  module V1
    class User < Grape::Entity
      expose :email
      expose :role
    end
  end
end
