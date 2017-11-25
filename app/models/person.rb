class Person < ApplicationRecord
	belongs_to :family

	def self.people_per_family
		people_hash = {}
		people = self.all.pluck(:family_id, :first_name, :last_name).each { |id, first, last|
			if people_hash.key?(id)
				people_hash[id].push({ :first_name => first, :last_name => last })
			else
				people_hash[id] = [{ :first_name => first, :last_name => last }]
			end
      	}
      	return people_hash
	end
end
