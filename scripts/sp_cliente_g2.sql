use cobis
go

IF OBJECT_ID ('dbo.sp_cliente_g2') IS NOT NULL
	DROP PROCEDURE dbo.sp_cliente_g2
GO

create procedure sp_cliente_g2
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
   @i_nombre				varchar(50) = null,
   @i_apellido				varchar(50) = null,
   @i_direccion				varchar(200)= null,
   @i_telefono				varchar(10) = null,
   @i_estado				char(1)		= 'V',
   @i_codigo				varchar(10) = null,
   @o_codigo              	int      	= null out

as
declare
   @w_codigo_cli	int,
   @w_error       	int,
   @w_return       	int,
   @w_sp_name		varchar(30)
   
select @w_sp_name = 'sp_cliente_g2'

if @i_operacion = 'I'
begin
    if @i_cedula is null
    begin
      select @w_error =  1720368 
      goto ERROR_FIN
	end
	if @i_nombre is null
    begin
      select @w_error =  1720369 
      goto ERROR_FIN
	end
	if @i_apellido is null
    begin
      select @w_error =  1720370 
      goto ERROR_FIN
	end
	
	select @w_codigo_cli=max(cl_codigo) 
	from cliente_grupo2
	
	if @w_codigo_cli is null
		select @w_codigo_cli = 0
	
	select @w_codigo_cli = @w_codigo_cli + 1
	
	
	if exists (select cl_cedula from cliente_grupo2 where cl_cedula = @i_cedula)
	begin
		select @w_error = 1720372
		goto ERROR_FIN
	end
	
    insert into cliente_grupo2
		(cl_codigo,		cl_cedula,		cl_nombre,
		 cl_apellido,	cl_direccion,	cl_telefono,
		 cl_estado)
	values 
		(@i_codigo,	@i_cedula,		@i_nombre,
		 @i_apellido,	@i_direccion,	@i_telefono,
		 @i_estado)
		
	select @o_codigo = @w_codigo_cli
end


if @i_operacion = 'U'
begin
 	if @i_codigo is null
    begin
	--Poner el error correspondiente [quitar el null]
      select @w_error =  null
      goto ERROR_FIN
	end

	if exists (select cl_cedula from cliente_grupo2 where cl_cedula = @i_cedula)
	begin
		select @w_error = 1720372
		goto ERROR_FIN
	end
	
	update cliente_grupo2
	SET cl_cedula 		= @i_cedula,
		cl_nombre 		= @i_nombre,
		cl_apellido		= @i_apellido,
		cl_direccion 	= @i_direccion,
		cl_telefono 	= @i_telefono
	where cl_codigo = @i_codigo

end
if @i_operacion = 'D'
begin
 	if @i_cedula is null
    begin
      select @w_error =  1720368 
      goto ERROR_FIN
	end

    update cliente_grupo2
	set cl_estado = 'E'
	where cl_cedula = @i_cedula
end

if @i_operacion = 'L'
begin
   select 
		'codigo' 	= cl_codigo,
		'cedula' 	= cl_cedula,
		'nombre' 	= cl_nombre,
		'apellido' 	= cl_apellido,
		'direccion' = cl_direccion,
		'telefono' 	= cl_telefono
	from cliente_grupo2
	where cl_estado = 'V'
end

if @i_operacion = 'Q'
begin
	if @i_nombre is null
    begin
      select @w_error =  1720369 
      goto ERROR_FIN
	end
	select 
		'codigo' 	= cl_codigo,
		'cedula' 	= cl_cedula,
		'nombre' 	= cl_nombre,
		'apellido' 	= cl_apellido,
		'direccion' = cl_direccion,
		'telefono' 	= cl_telefono
	from cliente_grupo2
	where cl_nombre like '%'+@i_nombre+'%'
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