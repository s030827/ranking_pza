ThinkingSphinx::Index.define :ascent, with: :active_record do
  indexes [user.name, user.surname], as: :user_name
  indexes line.name, as: :line_name
end
