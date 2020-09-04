defmodule SocializeWeb.PageController do
  use SocializeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
