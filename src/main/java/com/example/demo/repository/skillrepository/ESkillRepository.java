package com.example.demo.repository.skillrepository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.domain.skill.ESkill;

@Repository
public interface ESkillRepository extends JpaRepository<ESkill, Long> {

}
