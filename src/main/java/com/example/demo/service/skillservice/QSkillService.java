package com.example.demo.service.skillservice;

import org.springframework.stereotype.Service;

import com.example.demo.domain.skill.QSkill;
import com.example.demo.repository.skillrepository.QSkillRepository;

@Service
public class QSkillService {
    private final QSkillRepository qSkillRepository;

    public QSkillService(QSkillRepository qSkillRepository) {
        this.qSkillRepository = qSkillRepository;
    }

    public QSkill findQSkillById(long id) {
        return this.qSkillRepository.findById(id).get();
    }
}
