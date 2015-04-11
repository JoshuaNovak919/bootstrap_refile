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
  <%= form.attachment_field :profile_image, progress_class: 'progress-bar-danger' %>
<% end %>
```

Options:

- progress_class
- remove_class
- select_class
