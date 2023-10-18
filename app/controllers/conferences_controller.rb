class ConferencesController < ApplicationController
  def index
    @conferences = Conference.all
  end

  def new
    @conference = Conference.new
  end

  def create
    @conference = Conference.new(conference_params)

    if @conference.save
      flash[:success] = 'Nova conferência adicionada!'
      redirect_to action: :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @conference = Conference.find(params[:id])
  end

  def update
    @conference = Conference.find(params[:id])

    if @conference.update(conference_params)
      
      flash[:success] = 'Conferência atualizada!'
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @conference = Conference.find(params[:id])
  end

  def destroy
    @conference = Conference.find(params[:id])
    @conference.destroy

    flash[:success] = "Conferência removida com sucesso!"
    redirect_to root_path
  end

  private
  def conference_params
    params.require(:conference).permit(:id, :name, :duration)
  end
end