#
# Author: Sahil Ugale
# Date: 18/06/2024
# Description: This script is designed to work with the KLayout design automation tool. It programmatically
# inserts text instances into a layout in an array format. The script demonstrates how to manipulate layout
# data by dynamically placing text elements across the layout based on input parameters.
# Usage: To use this script, ensure you have KLayout installed and run this script within the KLayout
# scripting environment. Modify the `insert_params` array as needed to change the text placement.
# Dependencies: Requires KLayout to be installed.
#

# Retrieve the active layout and the top cell in the layout
ly = RBA::CellView::active.layout
matrix = ly.top_cell

# Function to insert text instances in an array format
def insert_text_instances(ly, matrix, sn_x, sn_y, mag, layer, text, columns, rows, column_vector, row_vector)
  abs_x = sn_x / ly.dbu
  abs_y = sn_y / ly.dbu

  # Define text parameters
  sn_param = {
    "layer" =&gt; layer,
    "text" =&gt; text,
    "mag" =&gt; mag
  }

  # Create a new cell for the text with the specified parameters
  sn_cell = ly.create_cell("TEXT", "Basic", sn_param)

  # Insert the text in the specified array format
  for r in 0...rows do
    for c in 0...columns do
      x = abs_x + column_vector[0] * c - row_vector[0] * r
      y = abs_y + column_vector[1] * c - row_vector[1] * r
      trans = RBA::Trans.new(RBA::Vector.new(x, y))
      matrix.insert(RBA::CellInstArray.new(sn_cell.cell_index, trans))
    end
  end
end

# Array of parameters for inserting "2" instances
insert_params = [

  { sn_x: (2101.0000 + 2 * 300.0000), sn_y: (5541.5300 - 200), columns: 1, rows: 5, column_vector: [0, 0], row_vector: [0, 200 / ly.dbu] },
  { sn_x: (2101.0000 + 2 * 300.0000) + 1400.0000, sn_y: (5541.5300 - 200), columns: 1, rows: 5, column_vector: [0, 0], row_vector: [0, 200 / ly.dbu] },
  { sn_x: (2101.0000 + 2 * 300.0000) + 2 * 1400.0000, sn_y: (5541.5300 - 200), columns: 1, rows: 5, column_vector: [0, 0], row_vector: [0, 200 / ly.dbu] },
  
  { sn_x: (2101.0000 + 2 * 300.0000), sn_y: (5541.5300 - 1600), columns: 1, rows: 5, column_vector: [0, 0], row_vector: [0, 200 / ly.dbu] },
  { sn_x: (2101.0000 + 2 * 300.0000) + 1400.0000, sn_y: (5541.5300 - 1600), columns: 1, rows: 5, column_vector: [0, 0], row_vector: [0, 200 / ly.dbu] },
  { sn_x: (2101.0000 + 2 * 300.0000) + 2 * 1400.0000, sn_y: (5541.5300 - 1600), columns: 1, rows: 5, column_vector: [0, 0], row_vector: [0, 200 / ly.dbu] },
  
  { sn_x: (2101.0000 + 2 * 300.0000), sn_y: (5541.5300 - 3000), columns: 1, rows: 5, column_vector: [0, 0], row_vector: [0, 200 / ly.dbu] },
  { sn_x: (2101.0000 + 2 * 300.0000) + 1400.0000, sn_y: (5541.5300 - 3000), columns: 1, rows: 5, column_vector: [0, 0], row_vector: [0, 200 / ly.dbu] },
  { sn_x: (2101.0000 + 2 * 300.0000) + 2 * 1400.0000, sn_y: (5541.5300 - 3000), columns: 1, rows: 5, column_vector: [0, 0], row_vector: [0, 200 / ly.dbu] },
  
  
  
  { sn_x: 1493.7000, sn_y: (5351.5300 - 600), columns: 5, rows: 1, column_vector: [300 / ly.dbu, 0], row_vector: [0, 0] },
  { sn_x: 1493.7000, sn_y: (5351.5300 - 600) - 1400.0000, columns: 5, rows: 1, column_vector: [300 / ly.dbu, 0], row_vector: [0, 0] },
  { sn_x: 1493.7000, sn_y: (5351.5300 - 600) - 2 * 1400.0000, columns: 5, rows: 1, column_vector: [300 / ly.dbu, 0], row_vector: [0, 0] },
  
  { sn_x: 2893.7000, sn_y: (5351.5300 - 600), columns: 5, rows: 1, column_vector: [300 / ly.dbu, 0], row_vector: [0, 0] },
  { sn_x: 2893.7000, sn_y: (5351.5300 - 600) - 1400.0000, columns: 5, rows: 1, column_vector: [300 / ly.dbu, 0], row_vector: [0, 0] },
  { sn_x: 2893.7000, sn_y: (5351.5300 - 600) - 2 * 1400.0000, columns: 5, rows: 1, column_vector: [300 / ly.dbu, 0], row_vector: [0, 0] },
  
  { sn_x: 4293.7000, sn_y: (5351.5300 - 600), columns: 5, rows: 1, column_vector: [300 / ly.dbu, 0], row_vector: [0, 0] },
  { sn_x: 4293.7000, sn_y: (5351.5300 - 600) - 1400.0000, columns: 5, rows: 1, column_vector: [300 / ly.dbu, 0], row_vector: [0, 0] },
  { sn_x: 4293.7000, sn_y: (5351.5300 - 600) - 2 * 1400.0000, columns: 5, rows: 1, column_vector: [300 / ly.dbu, 0], row_vector: [0, 0] }

]

# Insert "8" instances based on the parameters array
mag = 10
layer = RBA::LayerInfo.new(1, 0)
text = "8"

insert_params.each do |params|
  insert_text_instances(ly, matrix, params[:sn_x], params[:sn_y], mag, layer, text, params[:columns], params[:rows], params[:column_vector], params[:row_vector])
end