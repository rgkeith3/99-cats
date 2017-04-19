class CatRentalRequest < ApplicationRecord
  STATI = %w(Pending Approved Denied)
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: STATI,
    message: "Invalid status"}
  validate  :does_not_overlap_approved_request

  belongs_to :cat

  def overlapping_requests
    CatRentalRequest.where(['cat_id = ? AND id != ?', self.cat_id, self.id])
    .where.not([':end_date < start_date OR :start_date > end_date',
    {start_date: self.start_date, end_date: self.end_date}])
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "Approved")
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists? && self.status == "Approved"
      self.errors[:status] << "This cat is unavailable on those dates"
    end
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "Pending")
  end

  def approve!
    ActiveRecord::Base.transaction do
      self.status = "Approved"
      self.save
      overlapping_pending_requests.each do |request|

        request.deny!
      end
    end
  end

  def deny!
    self.status = "Denied"
    self.save
  end
end
