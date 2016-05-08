class DescribersProcessor
  def self.create_describers_for(movie_id)
    describers = {}
    movie = Movie.find(movie_id)
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
    filtered_words = overview + plot + storyline
    filtered_words.each do |word|
      if describers.key?word
        describers[word] += 1
      else
        describers[word] = 1
      end
    end
    describers = describers.sort_by { |_key, value| value }.reverse.to_h
    create_describers(movie_id, describers)
  end

  def self.load_stopwords
    stopwords = File.open('db/files/stopwords.txt').to_a
    stopwords.map { |word| word.delete("\n") }
  end

  def self.create_describers(movie_id, describers)
    describers.each do |k, v|
      next unless v > 1
      describer = Describer.find_or_create_by(name: k)
      MovieDescriber.create(
        movie_id: movie_id,
        describer: describer
      ) unless MovieDescriber.find_by(movie_id: movie_id, describer: describer)
    end
  end
end
