class CreateParticipantResults < ActiveRecord::Migration[6.0]
  def change
    create_table :participant_results do |t|

      t.integer :result
      t.integer :participant_id
      t.integer :game_id

      t.timestamps
    end
  end
end
