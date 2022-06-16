SET TERM ^ ;

create or alter procedure procgrantuser (
    novousuario varchar(20))
as
declare variable str varchar(100);
begin
  /* Procedure Text */

  for
     select ' grant all  on ' || trim(r.rdb$relation_name) || ' to ' || :novousuario  ||';' from rdb$relations r
     where r.rdb$system_flag = 0
     into :Str
     do begin
          execute statement :str;
     end

  for
     select ' grant execute  on  procedure ' || trim(p.rdb$procedure_name) || ' to '  || :novousuario ||';'  from rdb$procedures p
     where rdb$system_flag=0
     into :Str
     do begin
          execute statement :str;
     end

  str = 'REVOKE ALL ON ALL FROM PUBLIC';
  execute statement :str;


end^

SET TERM ; ^

/* Existing privileges on this procedure */

GRANT EXECUTE ON PROCEDURE PROCGRANTUSER TO SYSDBA;

