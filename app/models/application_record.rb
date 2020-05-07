class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  Refile.store ||= Refile::Backend::FileSystem.new("/tmp/uploads/store".to_s)
  Refile.cache ||= Refile::Backend::FileSystem.new("/tmp/uploads/cache".to_s)
end
