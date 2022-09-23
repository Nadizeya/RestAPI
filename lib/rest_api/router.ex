import Usercontroller
defmodule RestApi.Router do
  # Bring Plug.Router module into scope
  use Plug.Router
  # Attach the Logger to log incoming requests
  plug(Plug.Logger)
  # Tell Plug to match the incoming request with the defined endpoints
  plug(:match)
  # Once there is a match, parse the response body if the content-type
  # is application/json. The order is important here, as we only want to
  # parse the body if there is a matching route.(Using the Jayson parser)
  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )
  # Dispatch the connection to the matched handler
  plug(:dispatch)
  get "/users" do
    # %{"id" => id} = conn.params
    # c = String.to_integer(id)
    # IO.inspect(id)
    # IO.inspect(c)
    send_resp(conn, 200, list_all_user())
  end
  # Handler for GET request with "/" path
  get "/users/:userId" do
    %{"userId" => userId} = conn.params
    a = String.to_integer(userId)
    IO.inspect(userId)
    IO.inspect(a)
    send_resp(conn, 200, specific_user(a))
  end
  post "/users" do
    IO.inspect(conn.body_params)
    # a = String.to_integer(id)
    # IO.inspect(id)
    # IO.inspect(a)
    send_resp(conn, 201, create_user(conn.body_params))
  end
  delete "/users/:userId" do
    %{"userId" => userId} = conn.params
    a = String.to_integer(userId)
    IO.inspect(userId)
    IO.inspect(a)
    send_resp(conn, 200, delet_user(a))
  end
  patch "/users/:userId" do
    %{"userId" => userId} = conn.params
    e = String.to_integer(userId)
    IO.inspect(userId)
    send_resp(conn, 200, update_user(e, conn.body_params))
  end
  # Fallback handler when there was no match
  match _ do
    send_resp(conn, 404, "Not Found")
  end
end







