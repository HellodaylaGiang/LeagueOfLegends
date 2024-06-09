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

@Table(name = "r_skill")
public class RSkill {
    @Id
    private long id;
    private String Rname;
    private String Rdesc;
    private String Rvideo;
    private String Rimage;

    @OneToMany(mappedBy = "rSkill")
    List<Product> products;
}
