class AddRequestParamsToApis < ActiveRecord::Migration[6.0]
  def change
    add_column :apis, :request_params, :json, default: {}
  end
end
