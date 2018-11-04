defmodule Evercam.Cameras do
  alias Evercam.API

  def test_camera(camera_exid, vendor_id, external_url, jpg_url, user_name, password) do
    API.call(%{}, "/cameras/test", :post, %{
      external_url: external_url,
      jpg_url: jpg_url,
      cam_username: user_name,
      cam_password: password,
      vendor_id: vendor_id,
      camera_exid: camera_exid
    })
    |> API.handle_response
  end

  def get_camera(camera_id, thumbnail \\ false, client) do
    API.call(client, "/cameras/#{camera_id}", :get, %{
      thumbnail: thumbnail
    })
    |> API.handle_response
    |> received
  end

  def update_camera(camera_id, params \\ %{}, client) do
    API.call(client, "/cameras/#{camera_id}", :patch, params)
    |> API.handle_response
    |> received
  end

  def delete_camera(camera_id, client) do
    API.call(client, "/cameras/#{camera_id}", :delete)
    |> API.handle_response
  end

  def change_camera_owner(camera_id, user_id, client) do
    API.call(client, "/cameras/#{camera_id}", :put, %{
      user_id: user_id
    })
    |> API.handle_response
    |> received
  end

  def create_camera(name, is_public, params \\ %{}, camera_id \\ nil, client) do
    API.call(client, "/cameras", :post, %{
      name: name,
      is_public: is_public,
      id: camera_id
    } |> Map.merge(params))
    |> API.handle_response
    |> received
  end

  defp received({:error, message, status_code, _headers}) do
    {:error, message, status_code}
  end
  defp received({:ok, %{"cameras" => cameras}, status_code, _headers}) do
    {:ok, cameras, status_code}
  end
end
