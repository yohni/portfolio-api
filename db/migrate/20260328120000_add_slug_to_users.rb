class AddSlugToUsers < ActiveRecord::Migration[8.1]
  def up
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true

    User.reset_column_information
    User.find_each do |user|
      user.update_column(:slug, unique_slug_for(user.email_address, exclude_id: user.id))
    end

    change_column_null :users, :slug, false
  end

  def down
    remove_index :users, :slug
    remove_column :users, :slug
  end

  private

  def unique_slug_for(email_address, exclude_id:)
    base = email_address.to_s.split("@").first.to_s.parameterize
    base = "user" if base.blank?
    candidate = base
    suffix = 0
    while User.where(slug: candidate).where.not(id: exclude_id).exists?
      suffix += 1
      candidate = "#{base}-#{suffix}"
    end
    candidate
  end
end
