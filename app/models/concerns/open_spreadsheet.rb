module OpenSpreadsheet
  extend ActiveSupport::Concern

  def import_file file, accessible_attributes
    accessible_attributes = accessible_attributes
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      object = find_by_id(row["id"]) || new
      object.attributes = row.to_hash.slice(*accessible_attributes)
      object.save!
    end
  end

  def open_spreadsheet file
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, packed: nil, file_warning: :ignore)
    when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "t('unknown_file_type') #{file.original_filename}"
    end
  end
end
