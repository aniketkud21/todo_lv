defmodule TodoLiveViewWeb.PageLive do
  use TodoLiveViewWeb, :live_view
  alias TodoLiveView.Todos

  def mount(_params, _session, socket) do
    all_todos = Todos.list_todos()
    {:ok, assign(socket, number: 2, all_todos: all_todos, form: to_form(%{default_title: "Enter title", default_desc: "Description", default_status: "In-progress"}))}
  end

  def render(assigns) do
    ~H"""
    <%= @number %>
    <.button phx-click="add">Add</.button>

    <.simple_form for={@form} phx-submit="add-todo">
      <.input field={@form[:title]} value={@form.params.default_title}/>
      <.input field={@form[:desc]} value={@form.params.default_desc}/>
      <.input field={@form[:status]} value={@form.params.default_status}/>
      <.button>Add</.button>
    </.simple_form>

    <ul>
      <%= for item <- @all_todos do%>
        <%= for {_key, val} <- item do %>
          <li><%= val %></li>
        <% end %>
      <% end %>
    </ul>

    """
  end

  def handle_event("add", _unsigned_params, socket) do
    {:noreply, assign(socket, number: socket.assigns.number + 1)}
  end

  def handle_event("add-todo", add_todo, socket) do
    Todos.create_todo(add_todo)
    all_todos = Todos.list_todos()
    {:noreply, assign(socket, all_todos: all_todos)}
  end
end
