SET TERM ^ ;

CREATE OR ALTER PROCEDURE procGrantUserSYSDBA()
as
declare variable str varchar(100);
begin
  /* Procedure Text */

   for
     select ' revoke all  on ' || trim(r.rdb$relation_name) || ' from  SYSDBA' ||';' from rdb$relations r
     where r.rdb$system_flag = 0
     into :str
     do begin
        execute statement :str;
     end


  for
     select ' revoke all  on ' || trim(r.rdb$relation_name) || ' from  SYSDBA' ||';' from rdb$relations r
     where r.rdb$system_flag = 0
     into :str
     do begin
        execute statement :str;
     end


end^

SET TERM ; ^
GRANT EXECUTE ON PROCEDURE procGrantUser TO SYSDBA;







