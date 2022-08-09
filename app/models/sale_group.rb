class SaleGroup < ApplicationRecord
  validates :scraper, presence: true

  belongs_to :scraper
  has_many :sales, dependent: :destroy

  delegate :name, to: :scraper, prefix: true

  before_create :set_status
  after_save :stream_status_updated

  def finish!
    update!(status: true)
  end

  private

  def set_status
    self.status = false
  end

  def stream_status_updated
    broadcast_replace_to(self, target: 'status', partial: 'sale_groups/status', locals: { sale_group: self })
  end
end
