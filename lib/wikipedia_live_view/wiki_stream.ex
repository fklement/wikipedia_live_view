defmodule WikipediaLiveView.WikiStream do
  @url "https://stream.wikimedia.org/v2/stream/recentchange"

  def get() do
    Stream.resource(
      fn ->
        HTTPoison.get!(@url, %{},
          stream_to: self(),
          async: :once
        )
      end,
      fn %HTTPoison.AsyncResponse{id: id} = resp ->
        receive do
          %HTTPoison.AsyncStatus{id: ^id, code: code} ->
            HTTPoison.stream_next(resp)
            {[], resp}

          %HTTPoison.AsyncHeaders{id: ^id, headers: headers} ->
            HTTPoison.stream_next(resp)
            {[], resp}

          %HTTPoison.AsyncChunk{id: ^id, chunk: chunk} ->
            HTTPoison.stream_next(resp)
            {[chunk], resp}

          %HTTPoison.AsyncEnd{id: ^id} ->
            {:halt, resp}
        end
      end,
      fn resp -> :hackney.stop_async(resp.id) end
    )
  end

  def edits(pid) do
    get()
    |> Stream.filter(fn chunk ->
      String.starts_with?(chunk, "data: ") && String.ends_with?(chunk, "\n\n")
    end)
    |> Stream.map(fn edit ->
      format_and_decode(edit)
    end)
    |> Stream.filter(fn edit -> edit["wiki"] == "enwiki" end)
    |> Stream.each(fn data -> send(pid, {:add_edit, data}) end)
    |> Stream.run()
  end

  defp format_and_decode(plain_string) do
    formatted_string =
      plain_string
      |> String.slice(5..-1)
      |> String.slice(0..-3)

    case Jason.decode(formatted_string) do
      {:ok, decoded_string} -> decoded_string
      {:error, _} -> %{"wiki" => "uglysolutionbutcanfinderror"}
    end
  end
end
