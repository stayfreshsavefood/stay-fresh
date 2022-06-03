class InviteNotificationsController < ApplicationController
    before_action :set_fridge, only: [:new, :create]

    def index
      @invite_notification = InviteNotification.where(receiver_user_id: current_user.id)

    end

    def show
      raise
      @invitation = InviteNotification.find(params[])
    end

    def new
      @invite_notification = InviteNotification.new
    end

    def create
      @invite_notification = InviteNotification.new(invitation_params)
      @invite_notification.sender_user_id = current_user.id
      @receiver = User.where(email: invitation_params[:email])
      @invite_notification.status = false
      @invite_notification.receiver_user_id = @receiver.first.id
      @invite_notification.fridge_id = @fridge.id
      if @invite_notification.save
        redirect_to root_path, notice: 'Invitation sent.'
      else
        render :new, status: :unprocessable_entity, notice: 'Invitation failed'
      end
    end

    private

    def invitation_params
      params.require(:invite_notification).permit(:email)
    end

    def set_fridge
      @fridge = Fridge.find(params[:fridge_id])
    end
end
