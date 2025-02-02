package net.dzakirin.templatecrudbe.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import net.dzakirin.templatecrudbe.model.Fine;
import net.dzakirin.templatecrudbe.service.FineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/fines")
@Tag(name = "Fines Management", description = "APIs for managing library fines")
public class FineController {
    @Autowired
    private FineService fineService;

    // 🏷️ Get Unpaid Fines for a User
    @GetMapping("/{userId}")
    @Operation(summary = "Get all unpaid fines", description = "Retrieve all unpaid fines for a user.")
    public ResponseEntity<List<Fine>> getUnpaidFines(@PathVariable Long userId) {
        return ResponseEntity.ok(fineService.getUnpaidFinesByUser(userId));
    }

    // 💰 Pay a Fine
    @PutMapping("/pay/{fineId}")
    @Operation(summary = "Pay a fine", description = "Update a fine's status to 'Paid'.")
    public ResponseEntity<String> payFine(@PathVariable Long fineId) {
        fineService.payFine(fineId);
        return ResponseEntity.ok("Fine paid successfully");
    }
}

