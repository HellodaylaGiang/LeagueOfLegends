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

@Table(name = "w_skill")
public class WSkill {
    @Id
    private long id;
    private String Wname;
    private String Wdesc;
    private String Wvideo;
    private String Wimage;

    @OneToMany(mappedBy = "wSkill")
    List<Product> products;
}
