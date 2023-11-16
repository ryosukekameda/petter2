class Post < ApplicationRecord
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  has_one_attached :post_image
  
  validates :body, presence: true
  validates :post_image, presence: true
  
  def save_tags(tag_ids)
  # タグIDがnilの場合（チェックボックスが選択されなかった場合）、
  # 関連付けられているタグを全て削除します。
    return tags.clear if tag_ids.nil?

    current_tags = tags.pluck(:id)
    new_tags = tag_ids.map(&:to_i) - current_tags
    old_tags = current_tags - tag_ids.map(&:to_i)

    old_tags.each do |old_tag_id|
      tags.delete(Tag.find(old_tag_id))
    end

    new_tags.each do |new_tag_id|
      tag = Tag.find(new_tag_id)
      tags << tag unless tags.include?(tag)
    end
  end



  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("body LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("body LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("body LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("body LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
  def favorited_by?(user)
    return false unless user
    favorites.exists?(user_id: user.id)
  end
  
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
      post_image.variant(resize_to_limit: [width, height]).processed
  end
end