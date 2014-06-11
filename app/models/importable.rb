# require 'csv'
# require 'iconv'
#
# module Importable
#   extend ActiveSupport::Concern
#
#   module ClassMethods
#      def build_importer(attributes = {})
#         Importer.new(attributes.merge!(model: self))
#      end
#   end
# end
#
# class Importer
#   # switch to ActiveModel::Model in Rails 4
#   extend ActiveModel::Naming
#   include ActiveModel::Conversion
#   include ActiveModel::Validations
#
#   attr_accessor :file, :model
#
#   def initialize(attributes = {})
#     attributes.each { |name, value| send("#{name}=", value) }
#   end
#
#   def persisted?
#     false
#   end
#
#
#   def save
#     if imported.map(&:valid?).all?
#       imported.each(&:save!)
#       true
#     else
#       imported.each_with_index do |record, index|
#         record.errors.full_messages.each do |message|
#           errors.add :base, "Row #{index+2}: #{message}"
#         end
#       end
#       false
#     end
#   end
#
#   def imported
#     @imported ||= load_imported_records
#   end
#
#   def load_imported_records
#     spreadsheet = open_spreadsheet
#     header = spreadsheet.row(1)
#     (2..spreadsheet.last_row).map do |i|
#       row = Hash[[header, spreadsheet.row(i)].transpose]
#       record = model.find_by_id(row["id"]) || model.new
#       record.attributes = row.to_hash.slice(*model.accessible_attributes)
#       record
#     end
#   end
#
#   def open_spreadsheet
#     case File.extname(file.original_filename)
#       when ".csv" then Csv.new(file.path, nil, :ignore)
#       when ".xls" then Excel.new(file.path, nil, :ignore)
#       when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
#       else raise "Unknown file type: #{file.original_filename}"
#     end
#   end
# end
#
#
