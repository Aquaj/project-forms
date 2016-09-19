# Class representing a possible Answer to a Question.
class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :answers, dependent: :destroy
  validates :content, presence: true
end
