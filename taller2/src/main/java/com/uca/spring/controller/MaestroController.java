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
import com.uca.spring.repository.MaestroRepository;
import com.uca.spring.model.Maestro;
import com.uca.spring.util.CboFilter;

@Controller 
public class MaestroController { 
	@Autowired
	MaestroRepository maestroRepository;
	
	@RequestMapping(value = {"/"}, method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();          
        model.setViewName("maestros/index.jsp"); 
        return model;

    }
	 @RequestMapping(value = "/guardarMaestro", method = RequestMethod.POST)
	  public @ResponseBody
	  String saveAgdReferido(@ModelAttribute("Person") @Validated Maestro maestro) {
		  maestroRepository.save(maestro);
	      return null;
	  }
	 @RequestMapping(value = {"/obtenerMaestros"}, method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	  public @ResponseBody
	  List<Maestro> mostrarMaestros (){
		 List<Maestro> maestros=maestroRepository.findAll();  
		 return maestros;
	 }
	 @RequestMapping(value = {"/obtenerMaestro/{id}"}, method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	  public @ResponseBody
	  Optional<Maestro> mostrarMaestro (@PathVariable(value="id") int id){
		 Optional<Maestro> maestros=maestroRepository.findById(id);  
		 return maestros;
	 }
	 @RequestMapping(value = {"/modificarMaestro/{id}"}, method = RequestMethod.PUT, produces = "application/json;charset=UTF-8")
	  public @ResponseBody
	  String saveAgdReferido2(@ModelAttribute("Person") @Validated Maestro maestro,@PathVariable(value="id") int id) {
		  Maestro userFromDb = maestroRepository.getById(id);
		  userFromDb=maestro;
		  userFromDb.setIdMaestro(id); 
		  maestroRepository.save(userFromDb);
	      return null;
	  }
	 
	 @RequestMapping(value={"/eliminarMaestro/{id}"},method=RequestMethod.DELETE)
	 public @ResponseBody
	 boolean eliminarMaestro(@PathVariable(value = "id") int maestroId) {
	      maestroRepository.deleteById(maestroId); 
	      return true;
	 }  
    @RequestMapping(value = {"/agregarmaestros"}, method = RequestMethod.GET)
    public ModelAndView agregarMaestros(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();          
        model.setViewName("/maestros/index.jsp"); 
        return model;

    }
}
