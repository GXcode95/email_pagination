class EmailsController < ApplicationController
  before_action :set_email, only: %i[ show destroy ]
  include Pagination

  PAGE_SIZE = 20

  def index
    page_params
    @sended = params[:sended] || false
    emails = @sended ? Email.sended(current_user.email) : Email.received(current_user.email)
    @page, @max_pages, @emails = paginate(emails, params[:page], PAGE_SIZE)
    @unread = Email.unread_count(current_user)
    
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def show
    unless @email.read
      @email.read = true
      @email.save
    end
  end

  def new
    @email = Email.new

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def create
    @email = Email.new(email_params)
    if @email.save
      flash[:success] = "Email envoyé"
      respond_to do |format|
        format.html { redirect_to email_url(@email) }
        format.js {}
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.js { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @email.destroy
    flash[:success] = "Email supprimé"
    respond_to do |format|
      format.html { redirect_to emails_url }
      format.js {}
    end
  end

  private 
    def set_email
      @email = Email.find(params[:id])
    end

    def email_params
      params.require(:email).permit(:object, :content, :sender, :recipient, :read)
    end

    def page_params
      params.permit(:page, :sended)
    end
end
