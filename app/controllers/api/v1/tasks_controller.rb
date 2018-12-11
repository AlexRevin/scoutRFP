class Api::V1::TasksController < ApplicationController
  def index
    @tasks = Task.all
    render json: @tasks
  end

  def create
    title, tags =
      use_params(:title, :tags)
      .values_at(:title, :tags)
    @task = Task.create(title: title)
    tags.each do |tag|
      @task.tags.create title: tag
    end if tags
    render json: @task
  end

  def update
    title, id, tags =
      use_params(:title, :id, :tags)
      .values_at(:title, :id, :tags)
    @task = Task.where(id: id).first
    render(status: 404) && return unless @task.present?
    Tag.where(task_id: @task[:id]).destroy_all
    tags.each do |tag|
      @task.tags.create title: tag
    end if tags
    if @task.update(title: title)
      render json: @task
    end
  end

  private

  def use_params(*whitelist)
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params, only: whitelist
    )
  end
end
