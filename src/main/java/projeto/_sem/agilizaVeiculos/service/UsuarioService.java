package projeto._sem.agilizaVeiculos.service;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import projeto._sem.agilizaVeiculos.entity.Usuario.Usuario;
import projeto._sem.agilizaVeiculos.repository.UsuarioRepository;

@Service
public class UsuarioService {
    private UsuarioRepository usuarioRepository;

    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public List<Usuario> criarUsuario(Usuario usuario) {
        usuarioRepository.save(usuario);
        return listarUsuario();
    }

    public List<Usuario> listarUsuario() {
        Sort sort = Sort.by("idUsuario").ascending();
        return usuarioRepository.findAll(sort);
    }

    public List<Usuario> modificarUsuario(Usuario usuario) {
        usuarioRepository.save(usuario);
        return listarUsuario();
    }

    public List<Usuario> deletarUsuario(int idUsuario) {
        usuarioRepository.deleteById(idUsuario);
        return listarUsuario();
    }

}
