class Project < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
    validates :title, presence: true
    validates :title, length: {maximum: 100}
    has_many :analyses, dependent: :destroy
    belongs_to :user
    
    def should_generate_new_friendly_id?
        title_changed?
    end
end
