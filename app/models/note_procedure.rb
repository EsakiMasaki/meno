class NoteProcedure < ApplicationRecord
  belongs_to :note

  validates :procedure ,presence: true
  validates :explanation ,presence: true

  has_one_attached :procedure_image

  def get_procedure_image(width,height)
    unless procedure_image.attached?
      file_path = Rails.root.join("app/assets/images/default-image.jpg")
      procedure_image.attach(io: File.open(file_path),filename: "default-image.jpg")
    end
    procedure_image.variant(resize_to_limit: [width,height]).processed
  end
end
