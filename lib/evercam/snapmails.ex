defmodule Evercam.Snapmails do
  alias Evercam.API

  def get_snapmails(client) do
    API.call(client, "/snapmails", :get)
    |> API.handle_response
    |> received
  end

  def get_snapmail(id, client) do
    API.call(client, "/snapmails/#{id}", :get)
    |> API.handle_response
    |> received
  end

  def create_snapmail(subject, camera_exids, recipients, notify_days, notify_time, params \\ %{}, client) do
    API.call(client, "/snapmails", :post, %{
      subject: subject,
      camera_exids: camera_exids,
      recipients: recipients,
      notify_days: notify_days,
      notify_time: notify_time
    } |> Map.merge(params))
    |> API.handle_response
    |> received
  end

  def update_snapmail(id, params \\ %{}, client) do
    API.call(client, "/snapmails/#{id}", :patch, params)
    |> API.handle_response
    |> received
  end

  def delete_snapmail(id, client) do
    API.call(client, "/snapmails/#{id}", :delete)
    |> API.handle_response
  end

  def unsubscribe_snapmail(id, email, client) do
    API.call(client, "/snapmails/#{id}/unsubscribe/#{email}", :patch)
    |> API.handle_response
    |> received
  end

  defp received({:error, message, status_code, _headers}) do
    {:error, message, status_code}
  end
  defp received({:ok, %{"snapmails" => snapmails}, status_code, _headers}) do
    {:ok, snapmails, status_code}
  end
end
