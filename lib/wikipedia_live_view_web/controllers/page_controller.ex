defmodule WikipediaLiveViewWeb.PageController do
  use WikipediaLiveViewWeb, :controller
  alias Phoenix.LiveView

  def index(%Plug.Conn{path_info: path_info, request_path: path} = conn, _params) do
    case List.first(path_info) == "wiki" do
      true ->
        redirect_enwiki_requests(conn, path)

      _ ->
        LiveView.Controller.live_render(conn, WikipediaLiveViewWeb.EditsView, session: %{})
    end
  end

  def redirect_enwiki_requests(conn, path) do
    conn
    |> redirect(external: "https://en.wikipedia.org#{path}")
    |> halt
  end
end
