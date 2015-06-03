set SERVEROUTPUT ON SIZE 1000000;
set verify OFF;
  ACCEPT IDXXXX PROMPT 'Enter the value of IDXXXX : ';
set head off;
PROMPT Processing...;
DECLARE
  CURSOR UTC_cursor IS
    select c.TABLE_NAME, c.COLUMN_NAME 
    from USER_TAB_COLUMNS c, user_tables t
    where c.table_name = t.table_name 
    and c.COLUMN_NAME like '%ID%'
    and DATA_TYPE='NUMBER';
  UTC_record UTC_cursor%ROWTYPE;
  v_count integer;
  v_spelling VARCHAR2(2) :='es';
BEGIN
  FOR UTC_record IN UTC_cursor LOOP
    --FETCH UTC_cursor INTO UTC_record;
    --DBMS_OUTPUT.PUT_LINE('---');
   BEGIN
      v_spelling :='es';
      EXECUTE IMMEDIATE
            'select count(*) from '||
            UTC_record.TABLE_NAME||
            ' where '||
            UTC_record.COLUMN_NAME||
            ' = '||
            &&IDXXXX 
            INTO v_count;
      IF v_count>0 THEN
        IF v_count=1 THEN 
          v_spelling:=''; 
          END IF;
        DBMS_OUTPUT.PUT_LINE(v_count||' match'||v_spelling||' found in '||
                             UTC_record.TABLE_NAME||
                             ' / '||
                             UTC_record.COLUMN_NAME);
      END IF;
    END;    
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Done!');
END;
