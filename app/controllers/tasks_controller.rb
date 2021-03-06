# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params) if task_params.present?

    respond_to do |format|
      if @task&.save
        format.json { render json: @task.as_json, status: :created, location: @task }
      else
        format.json { render json: @task&.errors, status: :bad_request }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if task_params.present?
        if task_params.include?(:tags)
          tag_titles = task_params[:tags]
          tags = Tag.where(title: tag_titles)
          @task.tags = tags
        end
        @task.assign_attributes(task_params.except(:tags))
        @task.save
      end
      if task_params.empty? || @task.errors.present?
        format.json { render json: @task.errors, status: :bad_request }
      else
        format.json { render json: @task.as_json, status: :ok, location: @task }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit([:title, tags: []])
  end
end
