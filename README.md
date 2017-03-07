## Setup

```ruby
gem "paperclip-sql"
```

```ruby
class User < ActiveRecord::Base
  has_attached_file :image,
    :storage => :sql,
    :sql_options => { :table => Upload }
end
```

Note: this is originally based on https://github.com/janko-m/paperclip-dropbox
although there is no code from that left
