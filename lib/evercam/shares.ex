defmodule Evercam.Shares do
  alias Evercam.API

  def get_camera_share(camera_id, user_id, client) do
    API.call(client, "/cameras/#{camera_id}/shares", :get, %{
      user_id: user_id
    })
    |> API.handle_response
    |> received
  end

  def get_camera_shares(camera_id, client) do
    API.call(client, "/cameras/#{camera_id}/shares", :get)
    |> API.handle_response
    |> received
  end

  def delete_camera_share(camera_id, email, client) do
    API.call(client, "/cameras/#{camera_id}/shares", :delete, %{
      email: email
    })
    |> API.handle_response
  end

  def update_camera_share(camera_id, email, rights, client) do
    API.call(client, "/cameras/#{camera_id}/shares", :patch, %{
      email: email,
      rights: rights
    })
    |> API.handle_response
    |> received
  end

  def get_camera_share_users(camera_id, client) do
    API.call(client, "/shares/users", :get, %{
      camera_id: camera_id
    })
    |> API.handle_response
  end

  def get_camera_share_requests(camera_id, status \\ nil, client) do
    API.call(client, "/cameras/#{camera_id}/shares/requests", :get, %{
      status: status,
    })
    |> API.handle_response
    |> received
  end

  def cancel_camera_share_request(camera_id, email, client) do
    API.call(client, "/cameras/#{camera_id}/shares/requests", :delete, %{
      email: email,
    })
    |> API.handle_response
  end

  def update_camera_share_request(camera_id, email, rights, client) do
    API.call(client, "/cameras/#{camera_id}/shares/requests", :patch, %{
      email: email,
      rights: rights
    })
    |> API.handle_response
    |> received
  end

  def share_camera(camera_id, email, rights, params \\ %{}, client) do
    API.call(client, "/cameras/#{camera_id}/shares", :post, %{
      email: email,
      rights: rights
    } |> Map.merge(params))
    |> API.handle_response
    |> received
  end

  defp received({:ok, %{"errors" => errors, "share_requests" => share_requests, "shares" => shares}, status_code, _headers}) do
    {:ok, errors, share_requests, shares, status_code}
  end
  defp received({:error, message, status_code, _headers}) do
    {:error, message, status_code}
  end
  defp received({:ok, %{"shares" => shares}, status_code, _headers}) do
    {:ok, shares, status_code}
  end
  defp received({:ok, %{"share_requests" => share_requests}, status_code, _headers}) do
    {:ok, share_requests, status_code}
  end
end
