-----------INGRESO DE MENUS REUTILIZANDO EL SP INGRESO MENUS---------------------------
-----MENUS BDF (REPORTES)----------------------------------------------------------------------
declare @w_id_menu int
select @w_id_menu = me_id from cew_menu where me_name = 'MNU_BTEST'
-----La variable @w_id_menu se reutiliza para todos pues es el menu padre 
exec sp_menus_semillero 
	@i_url 							= 'views/FRNTN/RPRTS/T_FRNTNGUUDYOUQ_944/1.0.0/VC_FACTURASFP_920944_TASK.html', 
	@i_id_parent 					= @w_id_menu, 
	@i_name 						= 'MNU_BTEST1', 
	@i_description 					= 'MENU BUSQUEDA POR FECHAS', 
	@i_operacion					='I'

exec sp_menus_semillero 
	@i_url 							= 'views/FRNTN/RPRTS/T_FRNTNXKREPNXN_521/1.0.0/VC_FACTURASLP_523521_TASK.html', 
	@i_id_parent 					= @w_id_menu, 
	@i_name 						= 'MNU_BTEST2', 
	@i_description 					= 'MENU BUSQUEDA POR CEDULA', 
	@i_operacion					='I'
