class InvoicesController < ApplicationController
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction
  

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.for_user(current_user.id).search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 10) 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.for_user(current_user.id).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.json
  def new
    @invoice = Invoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.for_user(current_user.id).find(params[:id])
  end

  # POST /invoices
  # POST /invoices.json
  def create    
    @invoice = Invoice.new(params[:invoice])
    setup_chase_dates

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.json
  def update
    @invoice = Invoice.for_user(current_user.id).find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice = Invoice.for_user(current_user.id).find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
  end
  
  
  def setup_chase_dates
    # Setup the chase dates
    @current_setting = Setting.for_user(current_user.id)

    @invoice.user_id = current_user.id
    @invoice.pd_date = calculate_predue_date(@invoice.due_date, @current_setting[0].days_before_pre_due)        
    @invoice.od1_date = calculate_od1_date(@invoice.due_date, @current_setting[0].days_between_chase)        
    @invoice.od2_date = calculate_od2_date(@invoice.due_date, @current_setting[0].days_between_chase)        
    @invoice.od3_date = calculate_od3_date(@invoice.due_date, @current_setting[0].days_between_chase)    
  end

  def calculate_predue_date(due_date, days_before)
    due_date-days_before.days
  end
  
  def calculate_od1_date(due_date, chase_days)
    due_date+chase_days.days
  end
  
  def calculate_od2_date(due_date, chase_days)
    due_date+(chase_days*2).days
  end
  
  def calculate_od3_date(due_date, chase_days)
    due_date+(chase_days*3).days
  end
  
  private
  def sort_column
    Invoice.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"    
  end
  
end
