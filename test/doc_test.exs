defmodule Cldr.Calendar.Doc.Test do
  use ExUnit.Case, asynch: true

  doctest Cldr.Calendar
  doctest Cldr.Calendar.Duration
  doctest Cldr.Calendar.Interval
  doctest Cldr.Calendar.Kday
  doctest Cldr.Calendar.Preference

end
