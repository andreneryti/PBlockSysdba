CREATE OR ALTER trigger acesso
active on connect position 0
AS
begin
  if (current_user <> '%usuario%') then
     exception restrito;
end