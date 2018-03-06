class Report < Prawn::Document
    def initialize(analysis, results)
        super(top_margin: 50)
        @analysis = analysis
        @results = results
        print_cover
        analysis_result
    end


    def print_cover
        move_down 120
        formatted_text_box(
          [{ text: "Analysis report\n", styles: [:bold], size: 30, :align => :center }], at: [20, cursor - 50]
        )
        move_down 10
    end

    def analysis_result
        start_new_page
        table line_item_rows do
            row(0).font_style = :bold
            self.row_colors = ["DDDDDD","FFFFFF"]
        end

    end

    def line_item_rows
        table_data =[]
        header = ["Tool","CHROM", "Position","REF","ALT","ANN_IMPACT","ANN_Gene","ANN_Effect"]
        table_data << header
        @results.each do |item|
            table_data << [item.tool, item.CHROM, item.POS, item.REF, item.ALT, item.ANN_IMPACT, item.ANN_GENE, item.ANN_EFFECT]
        end
        table_data
    end

end