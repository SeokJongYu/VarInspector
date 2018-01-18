class Project < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
    validates :title, presence: true
    validates :title, length: {maximum: 100}
    has_many :data, dependent: :destroy
    has_many :analyses
    
    def should_generate_new_friendly_id?
        title_changed?
    end
end
