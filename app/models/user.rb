class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true

  has_many :answered_questions
  has_many :correct_answers, -> { where(correct: true) }, class_name: 'AnsweredQuestion'
  has_many :wrong_answers, -> { where(correct: false) }, class_name: 'AnsweredQuestion'
end
