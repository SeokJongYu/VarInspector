module Wizard
    module Analysis
      STEPS = %w(step1 step2 step3).freeze
  
      class Base
        include ActiveModel::Model
        attr_accessor :analysis
  
        delegate *::Analysis.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :analysis
  
        def initialize(analysis_attributes)
          @analysis = ::Analysis.new(analysis_attributes)
        end
      end
  
      class Step1 < Base
        validates :title, presence: true
        validates :description, presence: true        
      end
  
      class Step2 < Step1
        validates :first_name, presence: true
        validates :last_name, presence: true
      end
  
      class Step3 < Step2
        validates :address_1, presence: true
        validates :zip_code, presence: true
        validates :city, presence: true
        validates :country, presence: true
      end
  
      class Step4 < Step3
        validates :phone_number, presence: true
      end
    end
  end