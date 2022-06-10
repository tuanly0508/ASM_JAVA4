package com.laptopshop.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.laptopshop.entities.Post;

public interface PostService {
    Page<Post> getAllPostForPageable(int page, int size);

    List<Post> getAllPost();

    Post getPostById(long id);

    Post save(Post d);

    Post update(Post d);

    void deleteById(long id);
}
