package com.example.demo.service.skillservice;

import org.springframework.stereotype.Service;

import com.example.demo.domain.skill.Intrinsic;
import com.example.demo.repository.skillrepository.IntrinsicRepository;

@Service
public class ISkillService {
    private final IntrinsicRepository intrinsicRepository;

    public ISkillService(IntrinsicRepository intrinsicRepository) {
        this.intrinsicRepository = intrinsicRepository;
    }

    public Intrinsic findISkillById(long id) {
        return this.intrinsicRepository.findById(id).get();
    }
}
