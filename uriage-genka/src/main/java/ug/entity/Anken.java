package ug.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

/**
 * Ankenエンティティクラス
 *
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:08")
public class Anken implements Serializable {

    private static final long serialVersionUID = 1L;

    /** ankenIdプロパティ */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(precision = 10, nullable = false, unique = true)
    public Integer ankenId;

    /** latestRirekiNoプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer latestRirekiNo;

    /** insertDateプロパティ */
    @Column(nullable = false, unique = false)
    public Timestamp insertDate;

    /** updateDateプロパティ */
    @Column(nullable = false, unique = false)
    public Timestamp updateDate;

    /** AnkenRireki関連プロパティ */
    @OneToMany(mappedBy="anken")
    public List<AnkenRireki> ankenRirekiList;
}