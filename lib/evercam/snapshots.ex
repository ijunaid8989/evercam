defmodule Evercam.Snapshots do
  alias Evercam.API

  def get_snapshot(camera_id, client) do
    API.call(client, "/cameras/#{camera_id}/live/snapshot.jpg", :get)
    |> API.handle_response
  end

  def delete_snapshot(camera_id, from_date, to_date, client) do
    API.call(client, "/cameras/#{camera_id}/recordings/snapshots", :delete, %{
      from_date: from_date,
      to_date: to_date
    })
    |> API.handle_response
  end

  def get_live_image(camera_id, client) do
    API.call(client, "/cameras/#{camera_id}/live/snapshot", :get)
    |> API.handle_response
  end

  def get_snapshots(camera_id, from, to, limit \\ 3600, page \\ 0, client) do
    API.call(client, "/cameras/#{camera_id}/recordings/snapshots", :get, %{
      from: from,
      to: to,
      limit: limit,
      page: page
    })
    |> API.handle_response
    |> received
  end

  def get_latest_snapshot(camera_id, complete \\ false, client) do
    API.call(client, "/cameras/#{camera_id}/recordings/snapshots/latest", :get, %{
      with_data: complete,
    })
    |> API.handle_response
    |> received
  end

  def store_snapshot(camera_id, comment \\ nil, client) do
    API.call(client, "/cameras/#{camera_id}/recordings/snapshots", :post, %{
      notes: comment,
    })
    |> API.handle_response
    |> received
  end

  def get_snapshot_at(camera_id, timestamp, params \\ %{}, client) do
    API.call(client, "/cameras/#{camera_id}/recordings/snapshots/#{timestamp}", :get, params)
    |> API.handle_response
    |> received
  end

  defp received({:ok, %{"created_at" => created_at, "data" => image, "notes" => notes}, status_code, _headers}) do
    {:ok, image, created_at, notes, status_code}
  end
  defp received({:ok, %{"created_at" => created_at, "data" => image}, status_code, _headers}) do
    {:ok, image, created_at, status_code}
  end
  defp received({:error, message, status_code, _headers}) do
    {:error, message, status_code}
  end
  defp received({:ok, %{"snapshots" => snapshots}, status_code, _headers}) do
    {:ok, snapshots, status_code}
  end
  defp received({:ok, message, status_code, _headers}) do
    {:error, message, status_code}
  end
end
