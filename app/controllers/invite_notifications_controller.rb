class InviteNotificationsController < ApplicationController
    before_action :set_fridge, only: [:new, :create]

    def index
      @invite_notifications = InviteNotification.where(receiver_user_id: current_user.id,status: false)
    end

    def show
      @invitation = InviteNotification.find(params[])
    end

    def edit

    end

    def update
      @invitation = InviteNotification.find(params[:id])
      if params[:name]=="accept"
        @invitation.status = true
        @invitation.save!
        @new_fridge = FridgeUser.new(user_id: current_user.id, fridge_id: @invitation.fridge.id)
        @new_fridge.save!
        redirect_to root_path #, status: :ok, notice: 'You have new fridge'
        #@invitation.destroy
      elsif params[:name]=="decline"
        @invitation.destroy
        redirect_to root_path, notice: 'You declined the invitation', status: :ok
      end
    end

    def new
      @invite_notification = InviteNotification.new
    end

    def create
      @invite_notification = InviteNotification.new(invitation_params)
      @invite_notification.sender_user_id = current_user.id
      @receiver = User.find_by(email: invitation_params[:email])
      @invite_notification.status = false
      @invite_notification.receiver_user_id = @receiver.id
      @invite_notification.fridge_id = @fridge.id
      if @invite_notification.save!
        redirect_to root_path, notice: 'Invitation sent.'
      else
        render :new, status: :unprocessable_entity, notice: 'Invitation failed'
      end
    end

    def accept_invitation

    end

    private

    def invitation_params
      params.require(:invite_notification).permit(:email)
    end

    def set_fridge
      @fridge = Fridge.find(params[:fridge_id])
    end

    def set_status_invitation

    end
end
