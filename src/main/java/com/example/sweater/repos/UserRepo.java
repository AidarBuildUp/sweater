package com.example.sweater.repos;

import com.example.sweater.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserRepo extends JpaRepository<User, Long> {
    User findByUsername(String username);

    User findByActivationCode(String activationCode);

    @Query(value = "select case when exists (select * from user_subscriptions where channel_id = ?1 and subscription_id = ?2) then true else false end", nativeQuery = true)
    boolean isSubscribed (Long channelId, Long subscriptionId);

    @Query (value = "insert into user_subscriptions(channel_id, subscription_id) values (?1, ?2) returning true;", nativeQuery = true)
    boolean subscribe (Long channelId, Long subscriptionId);

    @Query (value = "delete from user_subscriptions where channel_id = ?1 and subscription_id =?2 returning true", nativeQuery = true)
    boolean unsubscribe (Long channelId, Long subscriptionId);

}
