class Invite < ActiveRecord::Base
  validates_presence_of :email, :message => "You didn't enter an email address"
  validates_presence_of :referrer, :if => Proc.new {|i| i.recommendation == true}, :message => "You didn't enter your name"
end
