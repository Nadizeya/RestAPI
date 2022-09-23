defmodule Usercontroller do
  alias Friends.Repo
  alias Friends.Person
  # def get_users do
  #     users =
  #     Friends.Repo.all
  #     |> Jason.encode()
  # end
  def create_user(userinfo) do
    # person = %Friends.Person{id: id, first_name: "Tun", last_name: "Tun", age: 22}
    result =
      Friends.Person.changeset(%Friends.Person{}, %{
        first_name: userinfo["first_name"],
        last_name: userinfo["last_name"],
        age: userinfo["age"]
      })
    IO.inspect(result)
    %Ecto.Changeset{valid?: validity} = result
    if validity == false do
      IO.inspect("Inupt error")
    else
      Friends.Repo.insert(result)
      IO.inspect("User Successfully created")
    end
    #  Friends.Person |> Ecto.Query.first
  end

  def list_all_user do
    # Friends.Person |> Friends.Repo.all
    Friends.Person
    |> Friends.Repo.all()
    |> Enum.map(fn x -> Map.drop(x, [:__meta__]) end)
    |> Enum.map(fn x -> Map.drop(x, [:__struct__]) end)
    |> Jason.encode!()
    # z|> Jason.encode!()
    # IO.inspect(z)
  end

  def delet_user(id) do
    person = Friends.Repo.get(Friends.Person, id)
    IO.inspect(Friends.Repo.delete(person))
    IO.inspect("User Deleted")
  end

  def specific_user(id) do
    # Friends.Person |> Friends.Repo.get(id)
    Friends.Person
    |> Friends.Repo.get(id)
    |> Map.drop([:__meta__])
    |> Map.drop([:__struct__])
    |> Jason.encode!()
  end

  def update_user(id, userinfo) do
    person = Friends.Person |> Ecto.Query.first() |> Friends.Repo.get(id)
    changeset = Friends.Person.changeset(person, userinfo)
    case Friends.Repo.update(changeset) do
      {:ok, person} ->
        IO.inspect("Updated")
      {:error, changeset} ->
        IO.inspect("Error")
        # do something with changeset
    end

  end
  
end