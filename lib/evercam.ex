defmodule Evercam do
  use HTTPoison.Base

  def process_request_url(url) do
    "https://media.evercam.io/v1" <> url
  end

  def process_request_body(body), do: body |> Poison.decode!

  def process_request_headers(headers) when is_map(headers) do
    Enum.into(headers, [])
  end

  def process_request_headers(headers), do: headers

  def process_request_options(options), do: options

  def process_response_body(body), do: body

  def process_response_chunk(chunk), do: chunk

  def process_response_headers(headers), do: headers

  def process_response_status_code(status_code), do: status_code
end
