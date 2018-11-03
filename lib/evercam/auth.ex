defmodule Evercam.Auth do
  import AuthValidator

  def new(params) do
    with :ok <- validate_params(params)
    do
      %{
        api_key: params["api_key"],
        api_id: params["api_id"],
        agent: params["agent"],
        requester_ip: params["requester_ip"],
        u_country: params["country"],
        u_country_code: params["country_code"]
      }
    end
  end
end