# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :set_tag, only: %i[show edit update destroy]

  # GET /tags or /tags.json
  def index
    @tags = Tag.all
    respond_to do |format|
      format.json { render json: @tags, status: :created, location: @tag }
    end
  end

  # GET /tags/1 or /tags/1.json
  def show; end

  # POST /tags or /tags.json
  def create
    @tag = Tag.new(tag_params) if tag_params.present?

    respond_to do |format|
      if @tag&.save
        format.json { render json: @tag, status: :created, location: @tag }
      else
        format.json { render json: @tag&.errors, status: :bad_request }
      end
    end
  end

  # PATCH/PUT /tags/1 or /tags/1.json
  def update
    respond_to do |format|
      if tag_params.present? && @tag.update(tag_params)
        format.json { render json: @tag, status: :ok, location: @tag }
      else
        format.json { render json: @tag.errors, status: :bad_request }
      end
    end
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = Tag.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tag_params
    params.require(:tag).permit(:title)
  end
end
