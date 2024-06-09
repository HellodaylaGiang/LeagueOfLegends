package com.example.demo.repository.skillrepository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.domain.skill.Intrinsic;

@Repository
public interface IntrinsicRepository extends JpaRepository<Intrinsic, Long> {

}
