class User < ApplicationRecord
  has_many :books

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image # ここを追加（_idは含めません）
  
  validates :name, length: { minimum: 2, maximum: 20 }, presence: true
  validates :introduction, length: { maximum: 50 }

  
end
