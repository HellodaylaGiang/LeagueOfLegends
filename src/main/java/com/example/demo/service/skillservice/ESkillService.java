package com.example.demo.service.skillservice;

import org.springframework.stereotype.Service;

import com.example.demo.domain.skill.ESkill;
import com.example.demo.repository.skillrepository.ESkillRepository;

@Service
public class ESkillService {
    private final ESkillRepository eSkillRepository;

    public ESkillService(ESkillRepository eSkillRepository) {
        this.eSkillRepository = eSkillRepository;
    }

    public ESkill findESkillById(long id) {
        return this.eSkillRepository.findById(id).get();
    }
}
