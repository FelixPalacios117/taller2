package com.uca.spring.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.uca.spring.model.Maestro;

public interface MaestroRepository extends JpaRepository<Maestro , Integer> { 
}
