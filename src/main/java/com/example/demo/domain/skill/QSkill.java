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

@Table(name = "q_skill")
public class QSkill {
    @Id
    private long id;
    private String Qname;

    private String Qdesc;

    private String Qvideo;

    private String Qimage;

    @OneToMany(mappedBy = "qSkill")
    List<Product> products;
}
