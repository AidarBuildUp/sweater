create table user_subscriptions (
  channel_id int8 not null references usr (id),
  subscription_id int8 not null references usr (id),
  primary key (channel_id, subscription_id)
)