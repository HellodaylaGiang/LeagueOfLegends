package com.example.demo.domain;

import java.util.List;

import com.example.demo.domain.skill.ESkill;
import com.example.demo.domain.skill.Intrinsic;
import com.example.demo.domain.skill.QSkill;
import com.example.demo.domain.skill.RSkill;
import com.example.demo.domain.skill.WSkill;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    List<OrderDetail> orderDetails;

    @ManyToOne
    @JoinColumn(name = "image_id")
    Image image1;

    @ManyToOne
    @JoinColumn(name = "q_id")
    QSkill qSkill;

    @ManyToOne
    @JoinColumn(name = "w_id")
    WSkill wSkill;

    @ManyToOne
    @JoinColumn(name = "e_id")
    ESkill eSkill;

    @ManyToOne
    @JoinColumn(name = "r_id")
    RSkill rSkill;

    @ManyToOne
    @JoinColumn(name = "i_id")
    Intrinsic iSkill;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    List<CartDetail> cartDetails;

    @NotBlank(message = "Không để trống tên")
    @Size(min = 3, message = "Name tối thiểu 3 kí tự")
    private String name;

    @Min(value = 3, message = "Lớn hơn bằng 3")
    private double price;
    private String image;

    @NotBlank(message = "Không được để trống detailDesc")
    @Column(columnDefinition = "MEDIUMTEXT")
    private String detailDesc;

    @NotBlank(message = "Không được để trống shortDesc")
    private String shortDesc;
    private long quantity;
    private long sold;
    private String factory;
    private String target;
}
