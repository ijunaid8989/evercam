defmodule Evercam.Auth do
  import AuthValidator

  defstruct api_key: nil, api_id: nil, debug: false, agent: nil, requester_ip: nil, u_country: nil, u_country_code: nil

  def new(), do: %__MODULE__{}
  def new(params) do
    with :ok <- validate_params(params)
    do
      %__MODULE__{
        api_key: params["api_key"],
        api_id: params["api_id"],
        debug: params["debug"],
        agent: params["agent"],
        requester_ip: params["requester_ip"],
        u_country: params["country"],
        u_country_code: params["country_code"]
      }
    end
  end
end