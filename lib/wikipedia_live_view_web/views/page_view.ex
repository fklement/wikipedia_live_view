defmodule WikipediaLiveViewWeb.PageView do
  use WikipediaLiveViewWeb, :view

  def get_card_type(type) do
    case type do
      "new" -> "notice-success"
      "edit" -> "notice-warning"
      "log" -> "notice-info"
      _ -> "notice"
    end
  end
end
