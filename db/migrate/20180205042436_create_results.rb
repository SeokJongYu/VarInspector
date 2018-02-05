class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_table :results do |t|
      t.string :CHROM
      t.integer :POS
      t.string :VCF_ID
      t.string :REF
      t.string :ALT
      t.string :FORMAT
      t.decimal :EB
      t.integer :GEN_DP
      t.integer :GEN_AD
      t.string :ANN_IMPACT
      t.string :ANN_GENE
      t.string :ANN_EFFECT
      t.string :ANN_HGVS_C
      t.string :ANN_HGVS_P
      t.string :dbNSFP_SIFT_pred
      t.string :dbNSFP_Polyphen2_HDIV_pred
      t.string :dbNSFP_Polyphen2_HVAR_pred
      t.string :dbNSFP_MutationTaster_pred
      t.string :dbNSFP_GERP_NR
      t.string :dbNSFP_GERP_RS
      t.decimal :dbNSFP_phastCons100way_vertebrate
      t.decimal :dbNSFP_CADD_phred
      t.integer :dbNSFP_ExAC_AC
      t.decimal :dbNSFP_ExAC_AF
      t.integer :dbNSFP_ExAC_Adj_AC
      t.decimal :dbNSFP_ExAC_Adj_AF
      t.integer :dbNSFP_ExAC_EAS_AC
      t.decimal :dbNSFP_ExAC_EAS_AF
      t.integer :dbNSFP_ExAC_SAS_AC
      t.decimal :dbNSFP_ExAC_SAS_AF
      t.integer :dbNSFP_ExAC_AFR_AC
      t.decimal :dbNSFP_ExAC_AFR_AF
      t.integer :dbNSFP_ExAC_AMR_AC
      t.decimal :dbNSFP_ExAC_AMR_AF
      t.integer :dbNSFP_ExAC_NFE_AC
      t.decimal :dbNSFP_ExAC_NFE_AF
      t.integer :dbNSFP_ExAC_FIN_AC
      t.decimal :dbNSFP_ExAC_FIN_AF
      t.references :analysis, foreign_key: true

      t.timestamps
    end
  end
end
