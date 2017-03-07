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
