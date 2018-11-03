defmodule AuthValidator do
  def validate_params(params) do
    IO.inspect params
    with :ok <- validate(:api_key, params["api_key"]),
         :ok <- validate(:api_id, params["api_id"]),
         do: :ok
  end

  defp validate(key, value) when value in [nil, ""], do: invalid(key)
  defp validate(key, value), do: String.valid?(value) |> is_string(key)

  defp is_string(true, _key), do: :ok
  defp is_string(_, key), do: invalid(key)

  defp invalid(key), do: {:invalid, "The parameter '#{key}' isn't valid."}
end