package com.example.demo.service.skillservice;

import org.springframework.stereotype.Service;

import com.example.demo.domain.skill.WSkill;
import com.example.demo.repository.skillrepository.WSkillRepository;

@Service
public class WSkillService {
    private final WSkillRepository wSkillRepository;

    public WSkillService(WSkillRepository wSkillRepository) {
        this.wSkillRepository = wSkillRepository;
    }

    public WSkill findWSkillById(long id) {
        return this.wSkillRepository.findById(id).get();
    }
}
