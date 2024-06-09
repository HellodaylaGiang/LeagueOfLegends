package com.example.demo.domain.skill;

import java.util.List;

import com.example.demo.domain.Product;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity

@Table(name = "e_skill")
public class ESkill {
    @Id
    private long id;
    private String Ename;
    private String Edesc;
    private String Evideo;
    private String Eimage;

    @OneToMany(mappedBy = "eSkill")
    List<Product> products;
}
