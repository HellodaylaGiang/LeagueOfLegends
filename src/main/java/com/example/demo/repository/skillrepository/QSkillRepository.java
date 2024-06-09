package com.example.demo.repository.skillrepository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.domain.skill.QSkill;

@Repository
public interface QSkillRepository extends JpaRepository<QSkill, Long> {

}
