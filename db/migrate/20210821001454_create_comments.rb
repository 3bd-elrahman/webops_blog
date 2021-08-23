class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.bigint :post_id
      t.bigint :user_id

      t.timestamps
    end

  end
end
