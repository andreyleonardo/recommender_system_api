class GenerateDescriberWorker
  include Sidekiq::Worker
  def perform
    logger.info 'Generating Describers'
    start = Time.zone.now

    Movie.find_each do |movie|
      DescribersProcessor.create_describers_for movie
    end
    logger.info Time.zone.now - start
  end
end
