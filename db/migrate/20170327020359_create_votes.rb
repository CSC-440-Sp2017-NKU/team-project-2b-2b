class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
        t.string   "votable_type"
        t.integer  "votable_id"
        t.string   "voter_type"
        t.integer  "voter_id"
        t.boolean  "vote_flag"
        t.string   "vote_scope"
        t.integer  "vote_weight"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
        t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    end
  end
end
