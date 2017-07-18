class DeliveryNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # for now deliverynotifier is kept in lib folder 
    notifier = DeliveryNotifier.new

  end
end
