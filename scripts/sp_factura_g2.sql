use cobis
go

IF OBJECT_ID ('dbo.sp_factura_g2') IS NOT NULL
	DROP PROCEDURE dbo.sp_factura_g2
GO


create procedure sp_factura_g2
   @s_srv                   varchar(30) = null,
   @s_ssn                   int         = null,
   @s_date                  datetime    = null,
   @s_ofi                   smallint    = null,
   @s_user                  varchar(30) = null,
   @s_rol		            smallint    = null,
   @s_term		            varchar(10) = null,
   @t_file		            varchar(14) = null,
   @t_trn		   	        int			= null,
   @t_debug              	char(1)     = 'N',
   @t_from               	varchar(32) = null,
   @i_operacion	   	        char(1),
   @i_cedula				varchar(10) = null,
   @i_fecha1				varchar(10) = null,
   @i_fecha2				varchar(10) = null,
   @o_codigo              	int      	= null out

as
declare
   @w_codigo_cli	int,
   @w_error       	int,
   @w_return       	int,
   @w_sp_name		varchar(30)
   
select @w_sp_name = 'sp_factura_g2'

if @i_operacion = 'F'
begin
	select 'Codigo' = ca.cf_codigo,
	'Fecha' = CONVERT(varchar,ca.cf_fecha,3),
	'Total' = ca.cf_total,
	'Nombre Cliente' = cli.[cli_nombre], 
	'Apellido Cliente' = cli.[cli_apellido]
	from gr3_factura_cabecera ca
	join [gr3_cliente] cli on ca.[cli_cedula] = cli.[cli_cedula] 
	 WHERE CAST( ca.cf_fecha AS DATE ) BETWEEN @i_fecha1 AND @i_fecha2
end

if @i_operacion = 'C'
begin
	if @i_cedula is null
    begin
      select @w_error =  1720368 
      goto ERROR_FIN
	end
	select 'Codigo' = cf_codigo,
	'Fecha' = CONVERT(varchar,cf_fecha,3),
	'Total' = ca.cf_total,
	'Nombre Cliente' = cli.[cli_nombre], 
	'Apellido Cliente' = cli.[cli_apellido]
	from gr3_factura_cabecera ca
	join [gr3_cliente] cli on ca.[cli_cedula] = cli.[cli_cedula] 
	where ca.[cli_cedula] = @i_cedula
end
return 0


ERROR_FIN:
begin
   exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,				
   @i_num    = @w_error 
end
return @w_error