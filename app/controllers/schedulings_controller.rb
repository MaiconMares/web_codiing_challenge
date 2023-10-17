class SchedulingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  include SchedulingHelper

  def index
  end

  def new
    @schedule = Scheduling.new
  end

  def create
    @schedule = Scheduling.new(schedule_params)

    if @schedule.save!
      conferences = extract_conferences_from_file(@schedule.file.url)
      
      Conference.insert_conferences_in_bulk(conferences) if conferences.present?

      registered_conferences = Conference.all.map(&:attributes)

      @scheduling = schedule_conferences_optimal(registered_conferences)

      render json: @scheduling
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  def edit; end

  def show; end

  def destroy; end

  def schedule_params
    params.permit(:file)
  end
end