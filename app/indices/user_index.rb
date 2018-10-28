ThinkingSphinx::Index.define :user, with: :active_record do
  indexes :name
  indexes surname, sortable: true
end
