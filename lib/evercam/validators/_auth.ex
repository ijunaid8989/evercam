defmodule AuthValidator do
  def validate_params(params) do
    with :ok <- validate(:api_key, params["api_key"]),
         :ok <- validate(:api_id, params["api_id"]),
         :ok <- validate(:debug, params["debug"]),
         do: :ok
  end

  defp validate(key, value) when value in [nil, ""], do: invalid(key)

  defp validate(:debug, true), do: :ok
  defp validate(:debug, false), do: :ok
  defp validate(:debug = key, _value), do: invalid(key)

  defp validate(key, value), do: String.valid?(value) |> is_string(key)

  defp is_string(true, _key), do: :ok
  defp is_string(_, key), do: invalid(key)

  defp invalid(key), do: {:invalid, "The parameter '#{key}' isn't valid."}
end