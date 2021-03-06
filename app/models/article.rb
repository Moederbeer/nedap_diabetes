class Article < ApplicationRecord
  require 'sanitize'
  before_save :sanitize_content
  validates :all_tags, :specialist, :title, :author, :content, :source, :explanation, presence: true
  validates :specialist_id, presence: true, numericality: { only_integer: true }
  #images
  validates :article_image, attachment_presence: true
  validates_with AttachmentSizeValidator, attributes: :article_image, less_than: 5.megabytes

  has_many :questions, inverse_of: :article, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy
  accepts_nested_attributes_for :questions
  belongs_to :specialist, inverse_of: :articles

  has_attached_file :article_image, styles: { medium: "720x180#", thumb: "100x100>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :article_image, content_type: /\Aimage\/.*\z/

  def sanitize_content
    Sanitize.fragment(content, Sanitize::Config::RELAXED)
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(', ')
  end

  def self.tagged_with(name)
    if Tag.find_by_name(name)
      Tag.find_by_name(name).articles
    else
      return
    end
  end
  
end
