module SoftDelete
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted_at: nil) }
    scope :only_deleted, -> { unscope(where: :deleted_at).where.not(deleted_at: nil) }
  end

  def delete
    update_column :deleted_at, Time.now if has_attribute? :deleted_at
  end

  def destroy(force = nil)
    if force
      if super()
        return !self.persisted?
      end
    else
      callbacks_result = transaction do
        run_callbacks(:destroy) do
          delete
        end
      end
      callbacks_result ? self : false
    end
  end

  def restore
    self.class.transaction do
      update_column :deleted_at, nil
    end
    self
  end

end
