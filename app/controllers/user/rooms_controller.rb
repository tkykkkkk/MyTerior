class User::RoomsController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @room = Room.create(user_id: current_user.id)
        @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
        @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
        redirect_to "/rooms/#{@room.id}"
    end 
    
    def show
        @room = Room.find(params[:id])
        if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
            @messages = @room.messages
            @message = Message.new
            @entries = @room.entries
            #Roomで相手の名前表示するために記述
            @myUserId = current_user.id
        else
            redirect_back(fallback_location: root_path)
        end
    end 
    
  def index
    # ユーザーが参加しているエントリーを取得
    @entries = current_user.entries.includes(:room)
    
    # 参加しているルームのIDを取得
    @room_ids = @entries.map(&:room_id)
    
    # 各ルームの最新メッセージのタイムスタンプを取得
    latest_messages = Message.where(room_id: @room_ids).group(:room_id).select('room_id, MAX(created_at) as latest_message_time')

    # ルームIDと最新メッセージのタイムスタンプをハッシュに保存
    latest_message_times = latest_messages.each_with_object({}) do |message, hash|
      hash[message.room_id] = message.latest_message_time
    end

    # 参加しているルームに属する他のユーザーとそのルームIDを取得し、最新メッセージのタイムスタンプでソート
    @dm_users = User.joins(:entries)
                    .where(entries: { room_id: @room_ids })
                    .where.not(id: current_user.id)
                    .select('users.*, entries.room_id')
                    .distinct
                    .sort_by { |user| latest_message_times[user.entries.find { |e| @room_ids.include?(e.room_id) }.room_id] }
                    .reverse

    # Kaminariでページネーションを適用
    @dm_users = Kaminari.paginate_array(@dm_users).page(params[:page]).per(10)
  end
   
end
