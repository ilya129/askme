class CreateHashtagsQuestionsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :hashtags, :questions do |t|
      t.index [:hashtag_id, :question_id], unique: true
    end
  end
end
