defmodule Linreg.Data do
  defstruct points: []
  alias __MODULE__

  def new do
    %Data{}
  end

  def add_point(%Data{points: points} = data, x, y) do
    %Data{data | points: [{x, y}] ++ points}
  end
end
