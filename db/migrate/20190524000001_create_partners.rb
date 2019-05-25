# frozen_string_literal: true

# Create component and table for partners
class CreatePartners < ActiveRecord::Migration[5.2]
  def up
    create_component unless BiovisionComponent.where(slug: 'partners').exists?
    create_partners unless Partner.table_exists?
  end

  def down
    drop_table :partners if Partner.table_exists?
  end

  private

  def create_partners
    create_table :partners, comment: 'Partner' do |t|
      t.references :language, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer :priority, limit: 2, default: 1, null: false
      t.timestamps
      t.boolean :visible, default: true, null: false
      t.string :name
      t.string :image
      t.string :url
    end
  end

  def create_component
    BiovisionComponent.create(slug: 'partners')
  end
end
