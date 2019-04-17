package com.example.sweater.repos;

import com.example.sweater.domain.Message;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Set;

public interface MessageRepo extends CrudRepository<Message, Long> {

    List<Message> findByTag(String tag);

    @Query(value = "update message set text = ?1, tag = ?2 where id = ?3 returning true", nativeQuery = true)
    boolean updateMessage (String text, String tag, Long id);

    @Query(value = "update message set text = ?1, tag = ?2, filename = ?3 where id = ?4  returning true", nativeQuery = true)
    boolean updateMessage (String text, String tag, String filename, Long id);

}
