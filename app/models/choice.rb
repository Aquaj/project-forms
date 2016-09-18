class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :answers, dependent: :destroy
  validates :content, presence: true
end
