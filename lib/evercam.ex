defmodule Evercam do
  use HTTPoison.Base

  def process_request_url(url) do
    "https://media.evercam.io/v1" <> url
  end
end
