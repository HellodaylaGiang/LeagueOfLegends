package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.domain.Image;
import com.example.demo.repository.ImageRepository;

@Service
public class ImageService {
    private final ImageRepository imageRepository;

    public ImageService(ImageRepository imageRepository) {
        this.imageRepository = imageRepository;
    }

    public Image getImageById(long id) {
        return this.imageRepository.findById(id).get();
    }

}
