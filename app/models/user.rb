class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :owned_tasks
  # Relacion muchos a muchos
  has_many :participations, class_name: 'Participant'
  # Tareas de la cuales el usuario paticipa
  # Variacion del has many
  # Muchas tareas desde
  has_many :tasks, through: :participations
  

end
