# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
    has_many :tasks
    # para que no entre vacio
    validates :name, :description, presence: true
    # VValidacion de unicidad
    #  validates :name, uniqueness: true
    # Sensibilidad a mayuscula para el name
    validates :name, uniqueness: { case_sensitive: false }
end