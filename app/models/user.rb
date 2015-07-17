class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :user_interests, dependent: :destroy
  has_many :interests, through: :user_interests
  
  has_many :approved_friendships, -> {where approved: true}, class_name: 'Friendship', dependent: :destroy
  has_many :pending_friendships, -> {where approved: false}, class_name: 'Friendship', dependent: :destroy
  has_many :potential_friendships, -> {where approved: false}, class_name: 'Friendship', foreign_key: "friend_id", dependent: :destroy

  has_many :pending_friends, through: :pending_friendships, source: :user #friends that user sends freind request to
  has_many :potential_friends, through: :potential_friendships, source: :user #friends taht user recieves freind requests from
  has_many :friends, through: :approved_friendships
  
  def request_friendship(user)
    friendship = Friendship.new(user_id: self.id, friend_id: user.id, approved: false)
    friendship.save
  end
  
  def accept_friendship(user)
    friendship = Friendship.find_by(user_id: user.id, friend_id: self.id)
    friendship.approved = true
    friendship.save
    
    new_friendship = Friendship.new(user_id: self.id, friend_id: user.id, approved: true)
    new_friendship.save
  end
  
  acts_as_messageable
  def name
    return self.username
  end
  
  def mailboxer_email(object)
    return self.email
  end
  
  def random_interested_user
    interested_users = []
    self.interests.each do |interest|
      
      interest.users.each do |user|
        isFriend = false
        self.friends.each do |friend|
          if user.id == friend.id || user.id == self.id
            isFriend = true
            break
          end
        end
        if isFriend == false
          interested_users << user
        end
      end
    end
    index = rand(interested_users.length)
    if(interested_users[index])
      return interested_users[index]
    else
      #flash[:success] = "Error, no users found!"
      redirect_to conversations_path(random: false)
    end
  end
  
  def random_user
    random_users = []
    User.all.each do |user|
      isFriend = false
      self.friends.each do |friend|
        if user.id == friend.id || user.id == self.id
          isFriend = true
          break
        end
      end
      if isFriend == false
        random_users << user
      end
    end
    index = rand(random_users.length)
    if(random_users[index])
      return random_users[index]
    else
      #flash[:success] = "Error, no users found!"
      redirect_to conversations_path(random: false)
    end
  end
  
end
