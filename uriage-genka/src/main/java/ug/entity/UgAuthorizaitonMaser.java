package ug.entity;

import java.io.Serializable;
import java.util.List;
import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;

/**
 * UgAuthorizaitonMaserエンティティクラス
 * 
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:09")
public class UgAuthorizaitonMaser implements Serializable {

    private static final long serialVersionUID = 1L;

    /** authIdプロパティ */
    @Id
    @Column(precision = 10, nullable = false, unique = true)
    public Integer authId;

    /** authNameプロパティ */
    @Column(length = 30, nullable = true, unique = false)
    public String authName;

    /** ukHistoryLookプロパティ */
    @Column(precision = 10, nullable = true, unique = false)
    public Integer ukHistoryLook;

    /** ukInsertプロパティ */
    @Column(precision = 10, nullable = true, unique = false)
    public Integer ukInsert;

    /** ukUpdateプロパティ */
    @Column(precision = 10, nullable = true, unique = false)
    public Integer ukUpdate;

    /** ukDeleteプロパティ */
    @Column(precision = 10, nullable = true, unique = false)
    public Integer ukDelete;

    /** gkInsertプロパティ */
    @Column(precision = 10, nullable = true, unique = false)
    public Integer gkInsert;

    /** gkUpdateプロパティ */
    @Column(precision = 10, nullable = true, unique = false)
    public Integer gkUpdate;

    /** themeInsertプロパティ */
    @Column(precision = 10, nullable = true, unique = false)
    public Integer themeInsert;

    /** themeUpdateプロパティ */
    @Column(precision = 10, nullable = true, unique = false)
    public Integer themeUpdate;

    /** uriageTankaUpdateプロパティ */
    @Column(precision = 10, nullable = true, unique = false)
    public Integer uriageTankaUpdate;

    /** empAuthRelationList関連プロパティ */
    @OneToMany(mappedBy = "ugAuthorizaitonMaser")
    public List<EmpAuthRelation> empAuthRelationList;
}