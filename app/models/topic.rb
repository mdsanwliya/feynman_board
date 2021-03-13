class Topic < ApplicationRecord
  attr_accessor :rubbish_count, :not_clear_count, :somewhat_count, :understand_count

  BLOCK_TYPES = {"rubbish" => "#f04732" , "not_clear" => "#25b1f0" , "somewhat" => "#ffd966", "understand" => "#a9d18e"}

  belongs_to :user

  # Add callback to calculate progress of topic
  before_save :calculate

  # Calculation of precentage of understanding topic.
  def calculate
    # Percentage of understanding is calculated by following
    self.progress_rate = ((sum_of_point.to_f / total_count.to_f) * 100.00).round(2)
  end

  def calculate_points
    # Each Block of text will be having upto 4 points 
    # (1 – Totally rubbish, 2- Not Clear, 3- Somewhat Understood, 4-Totally Understood).
    count = 1
    BLOCK_TYPES.each do |key, value|
      instance_variable_set("@#{key}_count", (scan_type(value) * count))
      count = count + 1
    end
  end

  def scan_type(type)
    description.scan(/(?=<span style=\"color:#{type}\">)/).count
  end

  # Sum of points got from each block 
  def sum_of_point
    # Calculating point of each block
    calculate_points
    # Sum
    rubbish_count + not_clear_count + somewhat_count + understand_count
  end

  def total_count
    description.scan(/(?=<span style)/).count * 4
  end
end
