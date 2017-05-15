package ug.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

/**
 * GkMemoTableエンティティクラス
 * 
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:08")
public class GkMemoTable implements Serializable {

    private static final long serialVersionUID = 1L;

    /** memoIdプロパティ */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(precision = 10, nullable = false, unique = true)
    public Integer memoId;

    /** gkIdプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer gkId;

    /** writeDateプロパティ */
    @Column(nullable = false, unique = false)
    public Timestamp writeDate;

    /** bikouプロパティ */
    @Column(length = 1000, nullable = true, unique = false)
    public String bikou;

    /** jokyoプロパティ */
    @Column(length = 1000, nullable = true, unique = false)
    public String jokyo;

    /** genkaKanri関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "gk_id", referencedColumnName = "gk_id")
    public GenkaKanri genkaKanri;
}