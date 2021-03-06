class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, only: %i[show edit update destroy]
  def new
    @ticket = @project.tickets.build
    authorize @ticket, :create?
    3.times { @ticket.attachments.build }
  end

  def create
    @ticket = @project.tickets.new
    whitelisted_params = ticket_params
    whitelisted_params.delete(:tag_names) unless policy(@ticket).tag?
    @ticket.attributes = whitelisted_params
    @ticket.author = current_user
    authorize @ticket, :create?

    if @ticket.save
      flash[:success] = 'Ticket has been created.'
      redirect_to [@project, @ticket]
    else
      flash.now[:danger] = 'Ticket has not been created.'
      render 'new'
    end
  end

  def search
    authorize @project, :show?
    if params[:search].present?
      @tickets = @project.tickets.search(params[:search])
    else
      @tickets = @project.tickets
    end
    render "projects/show"
  end

  def show
    authorize @ticket, :show?
    @comment = @ticket.comments.build(state_id: @ticket.state_id)
  end

  def edit
    authorize @ticket, :update?
  end

  def update
    authorize @ticket, :update?

    if @ticket.update(ticket_params)
      flash[:success] = 'Ticket has been updated.'
      redirect_to [@project, @ticket]
    else
      flash.now[:danger] = 'Ticket has not been updated.'
      render 'edit'
    end
  end

  def destroy
    authorize @ticket, :destroy?
    @ticket.destroy
    flash[:success] = 'Ticket has been deleted.'
    redirect_to @project
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:name, :description, :tag_names, attachments_attributes: %i[file file_cache])
  end
end
