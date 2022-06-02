class InviteNotificationsController < ApplicationController
    before_action :set_fridge, only: [:new, :create]

    def index

    end

    def show

    end

    def new
      @invite_notification = InviteNotification.new()
    end

    def create
      @invite_notification = InviteNotification.new(invitation_params)
      puts @invite_notification
      @invite_notification.sender_user_id = current_user.id
      puts `This is ur #{@invite_notification}`
      @receiver = User.where(email: invitation_params[:email])
      puts `This is ur #{@receiver}`
      @invite_notification.status = true
      puts @invite_notification
      @invite_notification.receiver_user_id = @receiver.id
      puts @invite_notification
      if @invite_notification.save
        puts "saved"
        redirect_to root_path, notice: 'Fridge was successfully created.'
      end
      puts "not enough attributes"
    end

    private

    def invitation_params
      params.require(:invite_notification).permit(:email)
    end

    def set_fridge
      @fridge = Fridge.find(params[:fridge_id])
    end
end
