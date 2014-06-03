class AddPermalinkToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :permalink, :string
    add_index :posts, :permalink, unique: true

    Post.select("id,title").each do |post|
      Post.find(post.id).update permalink: "#{post.id}-#{post.title.parameterize}"
    end
  end
end