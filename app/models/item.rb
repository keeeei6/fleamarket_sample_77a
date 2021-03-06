class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  has_many :like, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  belongs_to_active_hash :postage
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :shipping_method

  validates :images, presence: true
  validates :name, length: { maximum: 40 }, presence: true
  validates :detail, presence: true
  validates :price, presence: true
  validates :status_id, presence: true
  validates :postage_id, presence: true
  validates :shipping_day_id, presence: true
  validates :shipping_method_id, presence: true
  validates :prefecture_id, presence: true
  validates :category_id, presence: true
  validates :price,numericality: { only_integer: true,greater_than: 300, less_than: 9999999 }

  def change
    create_table :likes do |t|
      t.references :user, null: false
      t.references :item, null: false
      t.timestamps
    end
      create_table :items do |t|
        t.integer :price, null: false
        t.timestamps
      end
  end

  def self.search(search)
    if search
      Item.where('name LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end
end
