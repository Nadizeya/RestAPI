defmodule InsertTest do
  alias Friends.Repo
  alias Friends.Person
  # this is changes //

  def insert do
    person = %Person{}
    Repo.insert(person)
  end
end
