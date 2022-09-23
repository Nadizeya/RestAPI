defmodule InsertTest do
  alias Friends.Repo
  alias Friends.Person

  def insert do
    person = %Person{}
    Repo.insert(person)
  end
end
