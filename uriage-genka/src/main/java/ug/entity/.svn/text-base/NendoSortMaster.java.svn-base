package ug.entity;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;

/**
 * NendoSortMasterエンティティクラス
 *
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:09")
public class NendoSortMaster implements Serializable {

    private static final long serialVersionUID = 1L;

    /** monthプロパティ */
    @Id
    @Column(precision = 10, nullable = false, unique = true)
    public Integer month;

    /** sortプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer sort;

    /** monthlyGenka関連プロパティ */
    @OneToMany(mappedBy="nendoSortMaster")
    public List<MonthlyGenka> monthlyGenkaList;

}