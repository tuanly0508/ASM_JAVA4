package com.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.laptopshop.entities.Post;

public interface PostRepository extends JpaRepository<Post, Long> {

}
