class Sale < ApplicationRecord
  validates :sale_group, :title, :value, :image, :link, presence: true

  belongs_to :sale_group

  after_create :stream_sale_created

  private

  def stream_sale_created
    broadcast_append_to(sale_group)
  end
end
