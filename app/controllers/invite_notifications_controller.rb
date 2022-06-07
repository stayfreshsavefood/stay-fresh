class InviteNotificationsController < ApplicationController
    before_action :set_fridge, only: [:new, :create]
    before_action :set_invitation, only: [:update, :destroy]

    def index
      @invite_notifications = InviteNotification.where(receiver_user_id: current_user.id, status: false)
    end

    def show
      @invitation = InviteNotification.find(params[])
    end

    def edit

    end

    def update
      if params[:name] == "accept"
        @invitation.status = true
        @invitation.save!
        @new_fridge = FridgeUser.new(user_id: current_user.id, fridge_id: @invitation.fridge.id)
        @new_fridge.save!
        redirect_to root_path, status: :see_other, notice: 'You joined a new fridge'
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

    def destroy
      if params[:name] == "decline"
        @invitation.destroy
        redirect_to root_path, status: :see_other, notice: 'You declined the invitation'
      end
    end

    private

    def invitation_params
      params.require(:invite_notification).permit(:email)
    end

    def set_fridge
      @fridge = Fridge.find(params[:fridge_id])
    end

    def set_invitation
      @invitation = InviteNotification.find(params[:id])
    end
end
