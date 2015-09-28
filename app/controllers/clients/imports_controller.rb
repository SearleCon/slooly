class Clients::ImportsController < ApplicationController
  def create
    importer.import
    redirect_to clients_url, notice: t('flash.clients.imports.create', resouce_name: importer.row_success_count)
  rescue => error
    flash.now[:alert] = error.message
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
