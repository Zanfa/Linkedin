class SessionsController < ApplicationController
  before_action :reset_invite_key, except: :create

  def create

    user = User.with auth_hash
    PublishNetworkCrawl.new.async.perform(user.id)

    invite_key = session[:invite_key]
    if invite_key
      aggregator = Aggregator.find_by_invite_key(invite_key)
      unless aggregator.users.include? user.id
        aggregator.users = aggregator.users + [user.id]
        aggregator.save
      end

      redirect_to '/'
    else

      session[:user] = user.id
      aggregator = Aggregator.where(owner: user).first

      if aggregator
        redirect_to aggregator
      else
        redirect_to new_aggregator_path
      end
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end