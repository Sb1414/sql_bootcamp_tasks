CREATE OR REPLACE FUNCTION fnc_trg_person_update_audit() RETURNS TRIGGER AS $trg_person_update_audit$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        INSERT INTO person_audit SELECT CURRENT_TIMESTAMP AT TIME ZONE 'Europe/Moscow',
                                        'U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address;
    END IF;
    RETURN NULL;
END;
$trg_person_update_audit$ LANGUAGE plpgsql;

-- DROP TRIGGER trg_person_update_audit ON person;

CREATE TRIGGER trg_person_update_audit
    AFTER UPDATE ON person
    FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_update_audit();

UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;

-- TG_OP — переменная, существующая только в триггерных функциях,
-- в ней хранится имя операции, от которой сработал триггер (INSERT, UPDATE, DELETE)