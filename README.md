# Bootstrap Refile

A bootstrap styled single file uploader for refile with progress bar and image preview.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bootstrap_refile'
```

`bundle install` and restart your server to make the files available through the pipeline.

Add this line to your javascript file ( after `//= require refile` ):

```js
//= require bootstrap_refile
```


Add this line to your stylesheet:

```scss
@import "bootstrap_refile";
```


## Usage

``` erb
<%= form_for @user do |form| %>
  <%= form.bootstrap_attachment_field :profile_image %>
<% end %>
```

If you want to change the style of the progress bar you can pass it in:

``` erb
<%= form_for @user do |form| %>
  <%= form.bootstrap_attachment_field :profile_image, progress_class: 'progress-bar-danger' %>
<% end %>
```

## Options:

- progress_class
- remove_class
- select_class

## Note:

The filename field for Refile is required for this to work, so make sure to add it to your tables.

Another note, this is my first gem, so it's probably pretty awful, if you have a problem open an issue and and let me know if you know how to fix it.