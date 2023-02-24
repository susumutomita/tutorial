# frozen_string_literal: true

# Users テーブルにユーザーを追加するためのマイグレーション
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
