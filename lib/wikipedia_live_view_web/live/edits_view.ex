defmodule WikipediaLiveViewWeb.EditsView do
  use Phoenix.LiveView

  def render(assigns) do
    WikipediaLiveViewWeb.PageView.render("index.html", assigns)
  end

  def mount(session, socket) do
    stream_pid = Process.spawn(WikipediaLiveView.WikiStream, :edits, [self()], [:link])
    {:ok, assign(socket, edits: [], items: 5, stream_pid: stream_pid)}
  end

  def handle_info({:add_edit, new_event}, socket) do
    current_length = Kernel.length(socket.assigns.edits)

    old_events =
      case current_length < socket.assigns.items do
        false -> Enum.take(socket.assigns.edits, socket.assigns.items - 1)
        _ -> socket.assigns.edits
      end

    {:noreply, assign(socket, edits: [new_event | old_events])}
  end

  def handle_event("change-shown-events", %{"items" => items}, socket) do
    {:noreply, assign(socket, items: String.to_integer(items))}
  end
end
