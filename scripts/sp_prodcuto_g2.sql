use cobis
go

IF OBJECT_ID ('dbo.sp_prod_g2') IS NOT NULL
	DROP PROCEDURE dbo.sp_prod_g2
GO

create procedure sp_prod_g2
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
   @i_codigo				varchar(4)  = null,
   @i_nombre				varchar(20) = null,
   @i_precio				money 		= null,
   @i_estado				char(1)		= 'V',
   @o_codigo              	int      	= null out

as
declare
   @w_codigo_prod	int,
   @w_error       	int,
   @w_return       	int,
   @w_sp_name		varchar(30)
   
select @w_sp_name = 'sp_prod_g2'

if @i_operacion = 'I'
begin
    if @i_codigo is null
    begin
      select @w_error =  1720735 
      goto ERROR_FIN
	end
	if @i_nombre is null
    begin
      select @w_error =  1720736 
      goto ERROR_FIN
	end
	if @i_precio is null
    begin
      select @w_error =  1720737 
      goto ERROR_FIN
	end
	
	select @w_codigo_prod = max(pr_secuencial) 
	from producto_grupo2
	
	if @w_codigo_prod is null
		select @w_codigo_prod = 0
	
	select @w_codigo_prod = @w_codigo_prod + 1
	
	
	if exists (select pr_codigo from producto_grupo2 where pr_codigo = @i_codigo)
	begin
		select @w_error = 1720738
		goto ERROR_FIN
	end
	
    insert into producto_grupo2
		(pr_secuencial,		pr_codigo,		pr_nombre,
		 pr_precio,			pr_estado)
	values 
		(@w_codigo_prod,	@i_codigo,		@i_nombre,
		 @i_precio,			@i_estado)
		
	select @o_codigo = @w_codigo_prod
end


if @i_operacion = 'U'
begin
	if exists (select pr_codigo from producto_grupo2 where pr_codigo = @i_codigo)
	begin
		select @w_error = 1720738
		goto ERROR_FIN
	end
	
	update producto_grupo2
	set pr_nombre 		= @i_nombre,
		pr_precio		= @i_precio
	where pr_codigo 	= @w_codigo_prod

end
if @i_operacion = 'D'
begin
 	if @i_codigo is null
    begin
      select @w_error =  1720735 
      goto ERROR_FIN
	end

    update producto_grupo2
	set pr_estado = 'E'
	where pr_codigo = @i_codigo
end

if @i_operacion = 'L'
begin
   select 
   		'secuencial' = pr_secuencial,
		'codigo' 	= pr_codigo,
		'nombre' 	= pr_nombre,
		'precio'	= pr_precio
	from producto_grupo2
	where pr_estado = 'V'
end

if @i_operacion = 'Q'
begin
	if @i_nombre is null
    begin
      select @w_error =  1720736 
      goto ERROR_FIN
	end
	select 
		'secuencial' 	= pr_secuencial,
		'codigo' 	 	= pr_codigo,
		'nombre' 		= pr_nombre,
		'precio'		= pr_precio
	from producto_grupo2
	where pr_codigo like '%'+@i_codigo+'%'
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

GO