class RemoveChannelIdFromStreams < ActiveRecord::Migration
  def change
  	remove_column :streams, :channel_id
  end
end
