package com.laptopshop.api.admin;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.laptopshop.entities.DanhMuc;
import com.laptopshop.entities.Post;
import com.laptopshop.entities.ResponseObject;
import com.laptopshop.service.PostService;

@RestController
@RequestMapping("api/post")
public class PostApi {
    @Autowired
    private PostService postService;

    @GetMapping("/all")
    public Page<Post> getAllPost(@RequestParam(defaultValue = "1") int page) {
        return postService.getAllPostForPageable(page - 1, 6);
    }

    @GetMapping("/allForReal")
    public List<Post> getRealAllPost() {
        return postService.getAllPost();
    }

    @GetMapping("/{id}")
    public Post getPostById(@PathVariable long id) {
        return postService.getPostById(id);
    }

    @PostMapping(value = "/save")
    public ResponseObject addPost(@RequestBody @Valid Post newPost, BindingResult result,
            HttpServletRequest request) {

        ResponseObject ro = new ResponseObject();

        if (result.hasErrors()) {

            Map<String, String> errors = result.getFieldErrors().stream()
                    .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));
            ro.setErrorMessages(errors);

            List<String> keys = new ArrayList<String>(errors.keySet());
            for (String key : keys) {
                System.out.println(key + ": " + errors.get(key));
            }

            ro.setStatus("fail");
            errors = null;
            ;
        } else {
            postService.save(newPost);
            ro.setData(newPost);
            ro.setStatus("success");
        }
        return ro;
    }

    @PutMapping(value = "/update")
    public ResponseObject updatePost(@RequestBody @Valid Post editPost, BindingResult result,
            HttpServletRequest request) {

        ResponseObject ro = new ResponseObject();
        if (result.hasErrors()) {

            Map<String, String> errors = result.getFieldErrors().stream()
                    .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));
            ro.setErrorMessages(errors);
            ro.setStatus("fail");
            errors = null;

        } else {
            postService.update(editPost);
            ro.setData(editPost);
            ro.setStatus("success");
        }

        return ro;
    }

    @DeleteMapping("/delete/{id}")
    public String deletePost(@PathVariable long id, HttpServletRequest request) {
        postService.deleteById(id);
        request.getSession().setAttribute("listDanhMuc", postService.getAllPost());
        ;
        return "OK !";
    }
}
