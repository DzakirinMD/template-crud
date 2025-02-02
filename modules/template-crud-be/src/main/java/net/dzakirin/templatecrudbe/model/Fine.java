package net.dzakirin.templatecrudbe.model;

import jakarta.persistence.*;
import lombok.*;

@Data
@Entity
@NoArgsConstructor @AllArgsConstructor
@Table(name = "fines")
public class Fine {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long fineId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "borrow_id")
    private BorrowedBook borrowedBook;

    private Double fineAmount;

    @Column(nullable = false)
    private String status; // Unpaid, Paid
}

