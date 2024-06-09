package com.example.demo.repository.skillrepository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.domain.skill.RSkill;

@Repository
public interface RSkillRepository extends JpaRepository<RSkill, Long> {

}
