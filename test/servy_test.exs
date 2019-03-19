defmodule ServyTest do
  use ExUnit.Case, async: true
  doctest Servy

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "the untruth" do
    refute 1 + 1 == 3
  end
end
