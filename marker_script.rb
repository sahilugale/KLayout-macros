#
# Author: Sahil Ugale
# Date: 18/06/2024
# Description: This Ruby script is designed to be run within the KLayout design automation tool. It 
# focuses on retrieving the active layout and the top cell within that layout, then iterates over each 
# instance in the top cell to collect coordinates of specific instances named "sample_7x7". These 
# coordinates are collected into an array, sorted, and prepared for further operations such as serial 
# number insertion at specified locations.
# Usage: To use this script, ensure you have KLayout installed and run this script within the KLayout
# scripting environment. Modify the `insert_params` array as needed to change the text placement.
# Dependencies: Requires KLayout to be installed.


# Retrieve the active layout and the top cell in the layout
ly = RBA::CellView.active.layout
matrix = ly.top_cell

# Initialize an array to collect chip coordinates
chip_coordinates = []

# Iterate over each instance in the top cell (wafer)
matrix.each_inst do |inst|
  # Check if the cell name of the instance is "sample_7x7"
  # TODO: Modify this condition to match other cell names if needed
  if inst.cell.name == "sample_7x7"
    # For each transformation in the instance's cell array
    inst.cell_inst.each_trans do |array_trans|
      # Add the displacement (coordinates) of the transformation to the chip coordinates array
      chip_coordinates &lt;&lt; array_trans.disp
    end
  end
end

# Sort the collected chip coordinates
chip_coordinates.sort_by! { |pt| [pt.y, pt.x] }

# Define the parameters for the serial number insertion
sn_x = 2500.0
sn_y = 6300.0
mag = 600.0
layer = RBA::LayerInfo.new(1, 0)
sn_format = "AGK%03d"
sn = 1

# Iterate over the sorted chip coordinates
chip_coordinates.each do |pt|
  # Create a transformation for the text based on the chip coordinates and S/N field position
  trans = RBA::Trans.new(RBA::Vector.new(pt.x + sn_x / ly.dbu, pt.y + sn_y / ly.dbu))

  # Define the parameters for the text to be inserted
  sn_param = {
    "layer" =&gt; layer,         # The layer where the text will be placed
    "text" =&gt; sn_format % sn, # The serial number text formatted with the current counter value
    "mag" =&gt; mag              # The magnification for the text
  }

  # Create a new cell for the text with the specified parameters
  sn_cell = ly.create_cell("TEXT", "Basic", sn_param)

  # Insert the new cell into the wafer at the specified transformation
  matrix.insert(RBA::CellInstArray.new(sn_cell.cell_index, trans))

  # Increment the serial number counter
  sn += 1
end
