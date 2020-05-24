defmodule Linreg.Math do
  def map(value, in_min, in_max, out_min, out_max) do
    out_min + (out_max - out_min) * ((value - in_min) / (in_max - in_min))
  end
end
