class Cat < ApplicationRecord
  COLORS = ["orange", "black", "white", "tabby", "calico", "green"]
  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: COLORS,
    message: "Invalid color"}
  validates :sex, inclusion: { in: %w(M F),
    message: "Invalid Sex"}

  has_many :cat_rental_requests, dependent: :destroy

  def age
    (Date.today - birth_date) / 365
  end

  def not_denied_requests
    self.cat_rental_requests.where.not(status: "Denied").order(:start_date)
  end
end
