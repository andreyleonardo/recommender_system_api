class DescribersProcessor
  def self.create_describers_for(movie, combine)
    stopwords = load_stopwords
    storyline = []
    plot = []
    overview = []
    unless movie.overview.nil?
      overview = movie.overview.gsub(/\W\s?/, ' ').downcase.split(' ')
      overview = overview.select do |word|
        !stopwords.include?(word)
      end
    end
    unless movie.plot.nil?
      plot = movie.plot.gsub(/\W\s?/, ' ').downcase.split(' ')
      plot = plot.select do |word|
        !stopwords.include?(word)
      end
    end
    unless movie.storyline.nil?
      storyline = movie.storyline.gsub(/\W\s?/, ' ').downcase.split(' ')
      storyline = storyline.select do |word|
        !stopwords.include?(word)
      end
    end
    tf_overview = calculate_tf overview
    tf_plot = calculate_tf plot
    tf_storyline = calculate_tf storyline

    # If it's not combination method use only the best describers from each rank
    describers = [tf_overview.first, tf_plot.first, tf_storyline.first]

    # If it's to use combination use this call
    describers = combine_ranks(tf_overview, tf_plot, tf_storyline) if combine

    create_describers(movie.id, describers)
  end

  def self.load_stopwords
    stopwords = File.open('db/files/stopwords.txt').to_a
    stopwords.map { |word| word.delete("\n") }
  end

  def self.create_describers(movie_id, describers)
    describers.each do |item|
      next if item.nil?
      describer = Describer.find_or_create_by(name: item)
      MovieDescriber.create(
        movie_id: movie_id,
        describer: describer
      ) unless MovieDescriber.find_by(movie_id: movie_id, describer: describer)
    end
  end

  def self.calculate_tf(list)
    describers = {}
    list.each do |word|
      if describers.key?word
        describers[word] += 1
      else
        describers[word] = 1
      end
    end
    describers.sort_by { |_key, value| value }.reverse.to_h.keys
  end

  def self.combine_ranks(overview, plot, storyline)
    describers_ranked = {}
    bigger_array = if overview.size > plot.size
                     if overview.size > storyline.size
                       overview
                     else
                       storyline
                     end
                   elsif plot.size > storyline.size
                     plot
                   else
                     storyline
                   end
    bigger_array.each_with_index do |item|
      indexes = []
      combined_rank = 0
      indexes.push(overview.find_index(item), plot.find_index(item), storyline.find_index(item))
      indexes.compact!
      indexes.sort!
      indexes.push(indexes.last + 1) if indexes.size < 2
      indexes.push(indexes.last + 1) if indexes.size < 3

      indexes.each do |index|
        combined_rank += index
      end
      describers_ranked[item] = combined_rank
    end
    describers_ranked.sort_by { |_key, value| value }.to_h.keys
  end
end
