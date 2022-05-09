package com.uca.spring.model;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name="Maestro")
public class Maestro implements Serializable {
	  private static final long serialVersionUID = 1L; 
	  @Id
	  @GeneratedValue(
	      strategy= GenerationType.AUTO,
	      generator="native"
	  )
	  @GenericGenerator(
	      name = "native",
	      strategy = "native"
	  )
	  @Column(name = "ID_MAESTRO")
	  Integer idMaestro; 
	  @Column(name="NOMBRES",nullable=false)
	  String nombres; 
	  @Column(name="APELLIDOS",nullable=false)
	  String apellidos; 
	  @Column(name="TELEFONO",nullable=false) 
	  String telefono; 
	  @Column(name="CORREO",nullable=false)
	  String correo; 
	  @Column(name="DUI",nullable=false)
	  String dui; 
}
