package net.dzakirin.templatecrudbe.service;

import net.dzakirin.templatecrudbe.model.Fine;
import net.dzakirin.templatecrudbe.repository.FineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FineService {

    @Autowired
    private FineRepository fineRepository;

    public List<Fine> getUnpaidFinesByUser(Long userId) {
        return fineRepository.findByUserUserIdAndStatus(userId, "Unpaid");
    }

    public Fine payFine(Long fineId) {
        Fine fine = fineRepository.findById(fineId).orElseThrow(() -> new RuntimeException("Fine not found"));
        fine.setStatus("Paid");
        return fineRepository.save(fine);
    }
}
