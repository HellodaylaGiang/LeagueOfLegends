package com.example.demo.service.skillservice;

import org.springframework.stereotype.Service;

import com.example.demo.domain.skill.RSkill;
import com.example.demo.repository.skillrepository.RSkillRepository;

@Service
public class RSkillService {
    private final RSkillRepository rSkillRepository;

    public RSkillService(RSkillRepository rSkillRepository) {
        this.rSkillRepository = rSkillRepository;
    }

    public RSkill findRSkillById(long id) {
        return this.rSkillRepository.findById(id).get();
    }
}
