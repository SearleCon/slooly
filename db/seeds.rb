Plan.create!(description: 'Free Trial', duration: 1, cost: 0, active: true, free: true)
Plan.create!(description: 'Monthly (Full Price)', duration: 1, cost: 12, active: true, free: false)
Plan.create!(description: 'Bronze 3 (16% discount)', duration: 3, cost: 30, active: true, free: false)
Plan.create!(description: 'Silver 6 (33% discount)', duration: 6, cost: 48, active: true, free: false)
Plan.create!(description: 'Gold 12 (50% discount)', duration: 12, cost: 72, active: true, free: false)
