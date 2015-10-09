class IndexClientBusinessNameAndContactPersonFields < ActiveRecord::Migration
  def change
    execute "CREATE INDEX business_name_idx ON clients USING gist (business_name gist_trgm_ops);"
    execute "CREATE INDEX contact_person_idx ON clients USING gist (contact_person gist_trgm_ops);"
  end
end
