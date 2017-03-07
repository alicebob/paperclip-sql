## Setup

```ruby
gem "paperclip-sql"
```

Needs a table with at least these columns:
```ruby
create_table :uploads do |t|
  t.string "filename", null: false
  t.string "ctype", null: false
  t.binary "bits", null: false

  t.timestamps
end
```

Attach it to a model:
```ruby
class User < ActiveRecord::Base
  has_attached_file :image,
    :storage => :sql,
    :sql_options => { :table => Upload }
end
```

Note: this is originally based on https://github.com/janko-m/paperclip-dropbox
although there is no code from that left
