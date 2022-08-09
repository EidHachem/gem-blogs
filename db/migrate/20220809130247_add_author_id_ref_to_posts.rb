class AddAuthorIdRefToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :Author, foreign_key: { to_table: :users }
  end
end
