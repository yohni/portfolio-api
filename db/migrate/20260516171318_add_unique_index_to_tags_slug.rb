class AddUniqueIndexToTagsSlug < ActiveRecord::Migration[8.1]
  class Tag < ApplicationRecord
  end

  def up
    Tag.reset_column_information

    Tag.where(slug: [ nil, "" ]).find_each do |tag|
      base = tag.name.to_s.parameterize
      base = "tag" if base.blank?
      candidate = base
      suffix = 0
      while Tag.where(slug: candidate).where.not(id: tag.id).exists?
        suffix += 1
        candidate = "#{base}-#{suffix}"
      end
      tag.update_column(:slug, candidate)
    end

    remove_index :tags, name: "index_tags_on_name_and_slug"
    add_index :tags, :slug, unique: true
    change_column_null :tags, :slug, false
  end

  def down
    change_column_null :tags, :slug, true
    remove_index :tags, :slug
    add_index :tags, [ :name, :slug ], unique: true, name: "index_tags_on_name_and_slug"
  end
end
