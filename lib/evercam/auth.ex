defmodule Evercam.Auth do
  import AuthValidator

  defstruct api_key: nil, api_id: nil, debug: false, host: "https://media.evercam.io/v1", agent: nil, requester_ip: nil, country: nil, country_code: nil

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
        country: params["country"],
        country_code: params["country"]
      }
    end
  end
end