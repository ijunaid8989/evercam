defmodule Evercam.Public do
  alias Evercam.API

  def get_public_cameras(criteria \\ %{}) do
    API.call(%{}, "/public/cameras", :get, criteria)
    |> API.handle_response
  end
end