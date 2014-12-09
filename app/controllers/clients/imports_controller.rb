class Clients::ImportsController < ApplicationController
  def create
    importer.import
    redirect_to clients_url, notice: "#{importer.row_success_count} clients were imported successfully."
  rescue StandardError => e
    flash.now[:alert] = e.message
    render :new
  end

  private

  def importer
    @importer ||= ClientImporter.new(file_path, extension: file_extension, params: { user_id: current_user })
  end

  def file_path
    file_path = params[:client][:file].path
  end

  def file_extension
    File.extname(params[:client][:file].original_filename).delete('.').to_sym
  end
end
