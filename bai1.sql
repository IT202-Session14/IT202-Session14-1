UPDATE Wallets
SET balance = balance - 50000.00
WHERE patient_id = 1;
SELECT * FROM Wallets 
WHERE patient_id = 1;
SELECT * FROM Patient_Invoices WHERE patient_id = 1; 

DELIMITER //
CREATE PROCEDURE PayHopitalFee(IN p_patient_id INT, IN p_amout DECIMAL(18,2))
BEGIN 
	START TRANSACTION;
	IF (SELECT balance FROM Wallets WHERE patient_id = p_patient_id) < p_amout THEN
    ROLLBACK;
    ELSE 
    UPDATE Wallets
    SET balance = balance - p_amout
    WHERE patient_id = p_patient_id;
    UPDATE Patient_Invoices
    SET total_due = total_due - p_amout
    WHERE patient_id = p_patient_id;
    COMMIT;
    END IF;
END //
DELIMITER ;