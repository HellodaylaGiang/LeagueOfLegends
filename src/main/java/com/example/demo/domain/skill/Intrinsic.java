package com.example.demo.domain.skill;

import java.util.List;

import com.example.demo.domain.Product;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity

@Table(name = "intrinsic")
public class Intrinsic {
    @Id
    private long id;

    private String Iname;

    private String Idesc;

    private String Ivideo;

    private String Iimage;

    @OneToMany(mappedBy = "iSkill")
    List<Product> products;
}
