package com.uca.spring.controller;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import java.util.List;
import java.util.Optional;
import java.util.ArrayList;
import com.uca.spring.repository.CursoRepository;
import com.uca.spring.model.Curso;
import com.uca.spring.util.CboFilter;

@Controller 
public class CursoController {
	@Autowired
	CursoRepository cursoRepository;
	
	@RequestMapping(value = {"cursos"}, method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		model.setViewName("cursos/index.jsp");
		return model;
	}
	
	//Obtener cursos
	@RequestMapping(value = {"obtenerCursos"}, method=RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public @ResponseBody 
	List<Curso> mostrarCurso() {
		List<Curso> cursos = cursoRepository.findAll();
		return cursos;
	}
	
	//Guardar curso
	@RequestMapping(value = {"guardarCurso"} , method=RequestMethod.POST)
	public @ResponseBody
	String guardarCurso(@ModelAttribute("Curso") @Validated Curso curso) {
		cursoRepository.save(curso);
		return null;
	}
	
	//obtener curso por id
	@RequestMapping(value = {"obtenerCurso/{id}"}, method= RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public @ResponseBody
	Optional<Curso> curso (@PathVariable(value="id") int id) {
		Optional<Curso> curso = cursoRepository.findById(id);
		return curso;
	}
	
	
	//Modificar curso
	@RequestMapping(value = {"modificarCurso/{id}"}, method = RequestMethod.PUT, produces = "application/json;charset=UTF-8")
	public @ResponseBody
	String modificarCurso(@ModelAttribute("Curso") @Validated Curso curso, @PathVariable(value="id") int id) {
		Curso cursoUpdated = cursoRepository.getById(id);
		cursoUpdated = curso;
		cursoUpdated.setIdCurso(id);
		cursoRepository.save(cursoUpdated);
		return null;
	}
	
	//Eliminar curso
	@RequestMapping(value = {"eliminarCurso/{id}"}, method = RequestMethod.DELETE)
	public @ResponseBody
	boolean eliminarCurso(@PathVariable(value="id") int id) {
		cursoRepository.deleteById(id);
		return true;
	}
	
}
