class Auth < ActiveRecord::Migration
  def change
    create_table :url_auth_groups do |t|
      t.string :name
      t.index :name, unique: true
      
      t.timestamps
    end
    
    create_table :url_auth_users do |t|
      t.string :name
      t.string :api_code
      t.index :name, unique: true
      
      t.timestamps
    end
    
    create_table :url_auth_urls do |t|
      t.string :url_pattern
      t.string :name
      t.string :http_method
      
      t.timestamps
    end
    
    create_table :url_auth_groups_users do |t|
      t.integer :user_id
      t.integer :group_id
      t.index [:user_id, :group_id], unique: true
    end
    
    create_table :url_auth_groups_urls do |t|
      t.integer :group_id
      t.integer :url_id
      t.index [:url_id, :group_id], unique: true
    end
  end
end
