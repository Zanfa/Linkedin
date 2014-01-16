class SessionsController < ApplicationController
  before_action :reset_invite_key, except: :create

  def create

    user = User.with auth_hash
    session[:user] = user.id
    #PublishNetworkCrawl.new.async.perform(user.id)

    invite_key = session[:invite_key]
    if invite_key
      pool = Pool.find_by_invite_key(invite_key).tap do |pool|
        unless pool.users.include? user
          pool.users.push user
          pool.save
        end
      end

      redirect_to pool
    else

      pools = Pool.where(owner: user)

      if pools.count == 1
        redirect_to pools.first
      elsif pools.count > 1
        redirect_to root_path
      else
        redirect_to new_pool_path
      end
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end