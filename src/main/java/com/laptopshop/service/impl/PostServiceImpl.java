package com.laptopshop.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.laptopshop.entities.Post;
import com.laptopshop.repository.PostRepository;
import com.laptopshop.service.PostService;

@Service
public class PostServiceImpl implements PostService {
    @Autowired
    private PostRepository repo;

    @Override
    public Post save(Post d) {
        return repo.save(d);
    }

    @Override
    public Post update(Post d) {
        return repo.save(d);
    }

    @Override
    public void deleteById(long id) {
        repo.deleteById(id);
    }

    @Override
    public Page<Post> getAllPostForPageable(int page, int size) {
        return repo.findAll(PageRequest.of(page, size));
    }

    @Override
    public Post getPostById(long id) {
        return repo.findById(id).get();
    }

    @Override
    public List<Post> getAllPost() {
        return repo.findAll();
    }
}
