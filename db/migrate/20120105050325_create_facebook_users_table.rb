class CreateFacebookUsersTable < ActiveRecord::Migration
  def change
    transaction do
      create_table :facebook_users, :force => true, :id => false do |t|
        t.column :fb_uid, 'BIGINT', :null => false
        t.string :name, :email
        t.timestamps
      end
      execute "ALTER TABLE facebook_users ADD PRIMARY KEY (fb_uid);"
      add_column :users, :fb_uid, 'BIGINT'
      add_foreign_key_constraint :users, :facebook_users, :rkey => 'fb_uid', :fkey => 'fb_uid'
    end
  end
  
  def add_foreign_key_constraint(table, rtable, opts = {})
    rkey = opts[:rkey] || 'id'
    fkey = opts[:fkey] || "#{rtable.to_s.singularize}_#{rkey}"
    update = opts[:update] || 'NO ACTION'
    delete = opts[:delete] || 'NO ACTION'
    make_not_null(table, fkey) if opts[:not_null]
    execute(<<-SQL)
      DELETE FROM #{table} WHERE #{fkey} IS NOT NULL AND NOT EXISTS (SELECT * FROM #{rtable} AS rtable WHERE rtable.#{rkey} = #{table}.#{fkey});
      ALTER TABLE #{table}
        ADD CONSTRAINT #{table}_#{fkey}_fkey FOREIGN KEY (#{fkey})
            REFERENCES #{rtable} (#{rkey}) ON UPDATE #{update} ON DELETE #{delete};
    SQL
    execute(<<-SQL) unless opts[:skip_index]
      CREATE INDEX #{table}_#{fkey}_idx
        ON #{table} USING btree (#{fkey});
    SQL
  end
end