class NullSubscription
  def has_expired?
    false
  end

  def expires_in
    0
  end
end
