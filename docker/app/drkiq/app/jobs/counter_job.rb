class CounterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    21 + 21
  end
end
