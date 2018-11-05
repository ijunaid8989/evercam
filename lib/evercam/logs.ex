defmodule Evercam.Logs do
  alias Evercam.API

  def get_logs(camera_id, params \\ %{}, client) do
    API.call(client, "/cameras/#{camera_id}/logs", :get, params)
    |> API.handle_response
    |> received
  end

  def create_log(action, params \\ %{}, camera_id, client) do
    API.call(client, "/logs", :post, %{
      action: action,
      camera_exid: camera_id
    } |> Map.merge(params))
    |> API.handle_response
  end

  defp received({:error, message, status_code, _headers}) do
    {:error, message, status_code}
  end
  defp received({:ok, %{"camera_exid" => camera_exid, "camera_name" => camera_name, "logs" => logs}, status_code, _headers}) do
    {:ok, camera_exid, camera_name, logs, status_code}
  end
end
