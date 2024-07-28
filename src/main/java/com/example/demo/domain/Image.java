package com.example.demo.domain;

import java.util.List;

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

@Table(name = "images")
public class Image {

    @Id
    private long id;

    private String img1;
    private String imgName1;

    private String img2;
    private String imgName2;

    private String img3;
    private String imgName3;

    private String img4;
    private String imgName4;

    @OneToMany(mappedBy = "image1")
    List<Product> products;
}
