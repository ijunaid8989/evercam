defmodule Evercam.Users do
  alias Evercam.API

  def get_user(user, client) do
    API.call(client, "/users/#{user}", :get)
    |> API.handle_response
    |> received
  end

  def get_user_cameras(user, shared \\ false, thumbnail \\ false, client) do
    API.call(client, "/cameras", :get, %{
      include_shared: shared,
      thumbnail: thumbnail, 
      user_id: user
    })
    |> API.handle_response
    |> received
  end

  def update_user(user, params \\ %{}, client) do
    API.call(client, "/users/#{user}", :patch, params)
    |> API.handle_response
    |> received
  end

  def delete_user(user, client) do
    API.call(client, "/users/#{user}", :delete)
    |> API.handle_response
  end

  def create_user(first_name, last_name, user_name, email, password, token, country \\ nil, key \\ nil, referral_url \\ nil) do
    API.call(%{}, "/users", :post, %{
      firstname: first_name,
      lastname: last_name,
      username: user_name,
      email: email,
      password: password,
      token: token,
      country: country,
      share_request_key: key,
      referral_url: referral_url
    })
    |> API.handle_response
    |> received
  end

  defp received({:error, message, status_code, _headers}) do
    {:error, message, status_code}
  end
  defp received({:ok, %{"users" => users}, status_code, _headers}) do
    {:ok, users, status_code}
  end
  defp received({:ok, %{"cameras" => cameras}, status_code, _headers}) do
    {:ok, cameras, status_code}
  end
end