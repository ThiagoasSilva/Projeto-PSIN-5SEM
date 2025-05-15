package projeto._sem.agilizaVeiculos.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import projeto._sem.agilizaVeiculos.entity.Usuario.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

}