package projeto._sem.agilizaVeiculos.controller;

import java.util.List;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import projeto._sem.agilizaVeiculos.entity.Usuario.Usuario;
import projeto._sem.agilizaVeiculos.service.UsuarioService;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/usuario")
public class UsuarioController {
    private UsuarioService usuarioService;

    public UsuarioController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @PostMapping
    List<Usuario> criarUsuario(@RequestBody Usuario usuario) {
        return usuarioService.criarUsuario(usuario);
    }
    
    @GetMapping
    List<Usuario> listarUsuario() {
        return usuarioService.listarUsuario();
    }
    
    @PutMapping
    List<Usuario> modificarUsuario(@RequestBody Usuario usuario) {
        return usuarioService.modificarUsuario(usuario);
    }
    
    @DeleteMapping("/{idUsuario}")
    List<Usuario> deletarUsuario(@PathVariable("idUsuario") int idUsuario) {
        return usuarioService.deletarUsuario(idUsuario);
    }

}
