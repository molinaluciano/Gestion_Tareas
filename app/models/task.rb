# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user

  validates :participating_users, presence: true
  
  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  # VALIDACION PERSONALIZADA
  validate :due_date_validity

  # CALLBACK FOR CODE
  before_create :create_code
  # CALLBACK FOR PARTICIPANT_MAILER
  after_create :send_email
  # anidar informacion de participantes como tambien destruirla
  accepts_nested_attributes_for :participating_users, allow_destroy: true

  def due_date_validity
    return if due_date.blank?
    return if due_date > Date.today
    errors.add :due_date, I18n.t('task.errors.invalid_due_date')
  end
  # metodo del callback de creacion de code
  def create_code
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  # metodo de callbck de partipant_mailer
  def send_email
    (participants + [owner]).each do |user|
      ParticipantMailer.with(user: user, task: self).new_task_email.deliver!
    end
  end
end
