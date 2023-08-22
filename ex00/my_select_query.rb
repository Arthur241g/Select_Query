require 'csv'

# This class implements a simple select query on a CSV file.
class MySelectQuery

  # The constructor takes the content of the CSV file as input.
  def initialize(csv_content)
    # Read the CSV file and create a list of data rows.
    data_arr  = CSV.parse(csv_content)

    # Get the column titles.
    column_titles = data_arr.shift

    # If the first row is empty, remove it and also remove the first column from
    # all rows.
    if column_titles[0] == nil
      column_titles.shift
      data_arr.each {|entry| entry.shift}
    end

    # Create a data summary, which is a list of data rows represented as
    # dictionaries.
    @data = createDataSummary(column_titles, data_arr)
  end

  # This method creates a data summary from the given list of column titles and
  # data rows.
  def createDataSummary(column_titles, data)
    # Create an empty list to store the data summary.
    data_summary = []

    # Iterate over the data rows.
    data.each do |entry|
      # Create a new dictionary to store the data row.
      data_summary.push({})

      # Iterate over the column titles.
      entry.each_index do |index|
        # Get the value of the current column.
        entry_value = entry[index]

        # Add the key-value pair to the dictionary.
        data_summary[-1][:"#{column_titles[index]}"] = "#{entry_value}"
      end
    end

    # Return the data summary.
    return data_summary
  end

  # This method returns the rows where the value of the given column matches the
  # given criteria.
  def where(column_name, criteria)
    # Create an empty list to store the query results.
    @query_results = []

    # Iterate over the data summary.
    @data.each do |entry|
      # Check if the value of the given column matches the given criteria.
      if entry[:"#{column_name}"] == criteria
        # If it does, add the row to the query results.
        @query_results.push(entry.values.join(','))
      end
    end

    # Return the query results.
    return @query_results
  end
end

=begin This code tests the `where()` method.
 filtered_player_data = MySelectQuery.new(File.read("./test-data/Seasons_stats.csv"))
 print filtered_player_data.where("Player", "Curly Armstrong")

 filtered_player_data = MySelectQuery.new(File.read("./test-data/nba_player_data.csv"))
 print filtered_player_data.where("name", "Curly Armstrong")

 filtered_player_data = MySelectQuery.new(File.read("./test-data/nba_players.csv"))
 print filtered_player_data.where("name", "Curly Armstrong")
=end