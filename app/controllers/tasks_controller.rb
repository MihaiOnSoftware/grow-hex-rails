# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    respond_to do |format|
      task_json = @task.as_json(only: [:id, :title], include: [tags: { only: [:title] }])
      format.json { render json: task_json, location: @task }
    end
  end

  # POST /tasks or /tasks.json
  def create
    respond_to do |format|
      if task_params.present? && (@task = Task.create_and_tag(task_params_hash))
        format.json { render json: @task.as_json, status: :created, location: @task }
      else
        render_error(format)
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if task_params.empty?
        render_error(format)
      else
        @task.update_and_tag(**task_params_hash)
        render_updated_task(format)
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

  def render_updated_task(format)
    if @task.errors.present?
      render_error(format)
    else
      format.json { render json: @task.as_json, status: :ok, location: @task }
    end
  end

  def render_error(format)
    format.json { render json: @task&.errors, status: :bad_request }
  end

  def task_params_hash
    task_params.to_h.symbolize_keys
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit([:title, tags: []])
  end
end
