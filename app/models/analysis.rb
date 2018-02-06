class Analysis < ApplicationRecord
  include SeqUploader[:seq_blood1]
  include SeqUploader[:seq_blood2]
  include SeqUploader[:seq_brain1]
  include SeqUploader[:seq_brain2]
  belongs_to :project
  has_many :result
end
