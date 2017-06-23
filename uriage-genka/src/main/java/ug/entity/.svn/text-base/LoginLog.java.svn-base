package ug.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="login_log")
public class LoginLog {

	@Id
	@GeneratedValue
	@Column(name = "session_number")
	public Integer sessionNumber;
	@Column(name = "login_id")
	public String loginId;
	@Temporal(TemporalType.DATE)
	@Column(name = "login_timestamp")
	public Timestamp loginTimestamp;
	@Temporal(TemporalType.DATE)
	@Column(name = "logout_timestamp")
	public Timestamp logoutTimestamp;


}
