class Analysis < ApplicationRecord
  #include SeqUploader::Attachment.new(:seq_blood1, :seq_blood2, :seq_brain1, :seq_brain2)
  belongs_to :project

end
