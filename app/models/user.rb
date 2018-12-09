class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {
    normal: 0,
    premium: 300,
    admin: 700,
    owner: 999
  }

  def discount_percent
    case role
    when 'normal'
      0
    else
      10
    end
  end
end
