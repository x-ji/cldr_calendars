defmodule Cldr.Calendar.Test do
  use ExUnit.Case
  doctest Cldr.Calendar
  doctest Cldr.Calendar.Kday

  # :calendar module doesn't work with year 0 or negative years
  test "that iso week of year is same as erlang" do
    for year <- 0001..2200,
        month <- 1..12,
        day <- 1..Cldr.Calendar.Gregorian.days_in_month(year, month) do
      assert :calendar.iso_week_number({year, month, day}) ==
               Cldr.Calendar.Gregorian.iso_week_of_year(year, month, day)
    end
  end

  test "that Calendar.ISO dates and Cldr.Calendar.Gregorian dates are the same" do
    for year <- 0001..2200,
        month <- 1..12,
        day <- 1..Cldr.Calendar.Gregorian.days_in_month(year, month) do
      {:ok, iso} = Date.new(year, month, day, Calendar.ISO)
      {:ok, gregorian} = Date.new(year, month, day, Cldr.Calendar.Gregorian)
      assert Date.compare(iso, gregorian) == :eq
    end
  end

  test "that Cldr.Calendar.Gregorian dates all round trip" do
    for year <- 0001..2200,
        month <- 1..12,
        day <- 1..Cldr.Calendar.Gregorian.days_in_month(year, month) do
      {:ok, gregorian} = Date.new(year, month, day, Cldr.Calendar.Gregorian)
      {:ok, iso} = Date.convert(gregorian, Calendar.ISO)
      {:ok, converted} = Date.convert(iso, Cldr.Calendar.Gregorian)
      assert Date.compare(gregorian, converted) == :eq
    end
  end

  test "that Cldr.Calendar.ISOWeek dates all round trip" do
    for year <- 0001..2200,
        month <- 1..Cldr.Calendar.ISOWeek.weeks_in_year(year),
        day <- 1..7 do
      {:ok, iso_week} = Date.new(year, month, day, Cldr.Calendar.ISOWeek)
      {:ok, iso} = Date.convert(iso_week, Calendar.ISO)
      {:ok, converted} = Date.convert(iso, Cldr.Calendar.ISOWeek)
      assert Date.compare(iso_week, converted) == :eq
    end
  end

  test "that Cldr.Calendar.AU dates all round trip" do
    for year <- 0001..2200,
        month <- 1..12,
        day <- 1..Cldr.Calendar.AU.days_in_month(year, month) do
      {:ok, au} = Date.new(year, month, day, Cldr.Calendar.AU)
      {:ok, iso} = Date.convert(au, Calendar.ISO)
      {:ok, converted} = Date.convert(iso, Cldr.Calendar.AU)
      assert Date.compare(au, converted) == :eq
    end
  end

  test "that Cldr.Calendar.UK dates all round trip" do
    for year <- 0001..2200,
        month <- 1..12,
        day <- 1..Cldr.Calendar.UK.days_in_month(year, month) do
      {:ok, uk} = Date.new(year, month, day, Cldr.Calendar.UK)
      {:ok, iso} = Date.convert(uk, Calendar.ISO)
      {:ok, converted} = Date.convert(iso, Cldr.Calendar.UK)
      assert Date.compare(uk, converted) == :eq
    end
  end

  test "that Cldr.Calendar.US dates all round trip" do
    for year <- 0001..2200,
        month <- 1..12,
        day <- 1..Cldr.Calendar.US.days_in_month(year, month) do
      {:ok, us} = Date.new(year, month, day, Cldr.Calendar.US)
      {:ok, iso} = Date.convert(us, Calendar.ISO)
      {:ok, converted} = Date.convert(iso, Cldr.Calendar.US)
      assert Date.compare(us, converted) == :eq
    end
  end

  if function_exported?(Code, :fetch_docs, 1) do
    test "that no module docs are generated for a backend" do
      assert {:docs_v1, _, :elixir, _, :hidden, %{}, _} = Code.fetch_docs(NoDocs.Cldr.Calendar)
    end

    assert "that module docs are generated for a backend" do
      {:docs_v1, _, :elixir, "text/markdown", _, %{}, _} = Code.fetch_docs(MyApp.Cldr.Calendar)
    end
  end
end
