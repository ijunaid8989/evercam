defmodule Evercam.Archives do
  alias Evercam.API

  def get_archives(camera_id, client) do
    API.call(client, "/cameras/#{camera_id}/archives", :get)
    |> API.handle_response
    |> received
  end

  def get_archive(camera_id, archive_id, client) do
    API.call(client, "/cameras/#{camera_id}/archives/#{archive_id}", :get)
    |> API.handle_response
    |> received
  end

  def delete_archive(camera_id, archive_id, client) do
    API.call(client, "/cameras/#{camera_id}/archives/#{archive_id}", :delete)
    |> API.handle_response
  end

  def create_archive(camera_id, title, from_date, to_date, requested_by, embed_time \\ nil, public \\ nil, client) do
    API.call(client, "/cameras/#{camera_id}/archives", :post, %{
      title: title,
      from_date: from_date,
      to_date: to_date,
      requested_by: requested_by,
      embed_time: embed_time,
      public: public
    })
    |> API.handle_response
    |> received
  end

  def update_archive(camera_id, archive_id, values \\ %{}, client) do
    API.call(client, "/cameras/#{camera_id}/archives/#{archive_id}", :patch, values)
    |> API.handle_response
    |> received
  end

  defp received({:error, message, status_code, _headers}) do
    {:error, message, status_code}
  end
  defp received({:ok, %{"archives" => archives}, status_code, _headers}) do
    {:ok, archives, status_code}
  end
end
