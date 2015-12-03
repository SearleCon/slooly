namespace :subscriptions do
  desc 'Deactivate expired subscriptions'
  task expire: :environment do
    Subscription.active.select(&:expired?).each { |subscription| subscription.update(active: false) }
  end

end
