class Auxiliary < ActiveRecord::Migration
	def self.up
		execute "TRUNCATE schema_migrations;"
		execute "INSERT INTO schema_migrations VALUES ('20151121200908');"
	end
	def self.down
		raise ActiveRecord::IrreversibleMigration
	end
end
