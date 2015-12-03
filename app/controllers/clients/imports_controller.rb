module Clients
  class ImportsController < ApplicationController
    def create
      importer = ClientImporter.new(file_path, extension: file_extension, params: { user_id: current_user })
      importer.import
      redirect_to clients_url, notice: "#{importer.row_success_count} were imported successfully}"
    rescue => error
      flash.now[:alert] = error.message
      render :new
    end

    private

    def file_path
      params[:client][:file].path
    end

    def file_extension
      File.extname(params[:client][:file].original_filename).delete('.').to_sym
    end
  end
  end
