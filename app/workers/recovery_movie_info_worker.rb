class RecoveryMovieInfoWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false, dead: false
  def perform(run_recommender)
    # logger.info 'Processing Movie Info'
    puts 'Processing Movie Info'
    start = Time.zone.now
    Link.find_each do |link|
      movie = link.movie
      if movie.overview.nil? && !link.tmdb_id.nil?
        sleep(0.33)
        tmdb = Tmdb::Find.movie(link.imdb_id, external_source: 'imdb_id')
        movie.overview = tmdb[0].overview unless tmdb.empty?
        movie.save
      end
      if movie.plot.nil? || movie.rate.nil?
        omdb_response = RestClient.get 'http://www.omdbapi.com', params: { i: link.imdb_id }
        omdb = JSON.parse(omdb_response)
        movie.rate = omdb['Rated']
        movie.plot = omdb['Plot']
        movie.save
      end
    end
    puts Time.zone.now - start
    RecommenderProcessWorker.perform_async if run_recommender
  end
end
