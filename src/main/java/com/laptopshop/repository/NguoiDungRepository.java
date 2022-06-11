package com.laptopshop.repository;

import java.util.List;
import java.util.Set;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.laptopshop.entities.NguoiDung;
import com.laptopshop.entities.VaiTro;

public interface NguoiDungRepository extends JpaRepository<NguoiDung, Long> {

	NguoiDung findByEmail(String email);

	NguoiDung findByCodeEmail(String codeEmail);

	Page<NguoiDung> findByVaiTro(Set<VaiTro> vaiTro, Pageable of);

	List<NguoiDung> findByVaiTro(Set<VaiTro> vaiTro);
}
