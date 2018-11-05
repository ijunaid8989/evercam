defmodule Evercam.API do
  require Logger
  require IEx

  def call(client \\ %{}, path, verb, params \\ %{}) do
    starting = DateTime.utc_now
    values = Map.merge(client, params) |> Map.to_list
    response = Evercam.request(verb, path, "", [], params: values)
    finished = DateTime.utc_now
    Logger.info "API Call Took: #{DateTime.diff(finished, starting)}"
    response
  end

  def handle_response({:error, struct}), do: {:error, "There was an error", struct, ""}
  def handle_response({:ok, %{body: body, headers: headers, status_code: status_code}}) do
    with true <- is_nil(body) do
      message = "API call failed to return any data or contained data that could not be parsed."
      {:error, message, status_code, headers}
    else
      _ ->
        parse_headers_body(headers, body, status_code)
    end
  end

  def parse_headers_body(headers, body, status_code) do
    {_, type} = List.keyfind(headers, "Content-Type", 0)
    what_will_retrun(type, body, status_code, headers)
  end

  defp what_will_retrun("image/jpeg", body, _status_code, _headers), do: body
  defp what_will_retrun(_type , body, status_code, headers) do
    Poison.decode!(body)
    |> handle_not_nil_response(status_code, headers)
  end

  def handle_not_nil_response(%{"message" => message} = _body, status_code, headers) do
    {:error, message, status_code, headers}
  end
  def handle_not_nil_response(body, status_code, headers) do
    {:ok, body, status_code, headers}
  end
end
