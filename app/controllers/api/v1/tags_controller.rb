class Api::V1::TagsController < ApplicationController
  def index
    @tags = Tag.all
    render json: @tags
  end

  def create
    @tag = Tag.create use_params(:title)
    render json: @tag
  end

  def update
    title, id =
      use_params(:title, :id)
      .values_at(:title, :id)
    @tag = Tag.where(id: id).first
    render(status: 404) && return unless @tag.present?
    if @tag.update(title: title)
      render json: @tag
    end
  end

  private

  def use_params(*whitelist)
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params, only: whitelist
    )
  end
end
