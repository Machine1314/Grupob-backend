/*
 * Archivo: DatosFacturaQueryFecha_Q_DATOTCUF_WG71.java
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.cobis.frntn.customevents.impl.query.executequery;

import java.util.List;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.frntn.model.DatosFactura;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.api.managers.DesignerManagerException;
import com.cobiscorp.designer.bli.api.IBLIExecutor;

@Component
@Service({ IExecuteQuery.class })
@Properties(value={
		@Property(name = "query.id", value = "Q_DATOTCUF_WG71"),
		@Property(name = "query.version", value = "1.0.0")})

public class DatosFacturaQueryFecha_Q_DATOTCUF_WG71 implements IExecuteQuery {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(DatosFacturaQueryFecha_Q_DATOTCUF_WG71.class);
	@Reference(bind="setBliBuscarFacturaFechas",
			unbind="unsetBliBuscarFacturaFechas", 
			cardinality = ReferenceCardinality.MANDATORY_UNARY,
			target = "(bli.id=BLI4715_bli_buscarfacturasfecha)")
	private IBLIExecutor bliBuscarFacturaFechas;
	public void setBliBuscarFacturaFechas(IBLIExecutor bliBuscarFacturaFechas) {
		this.bliBuscarFacturaFechas = bliBuscarFacturaFechas;
	}
	public void unsetBliBuscarFacturaFechas(IBLIExecutor bliBuscarFacturaFechas) {
		this.bliBuscarFacturaFechas = null;
	}
	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {
		// TODO Auto-generated method stub
		Map<String,Object> data = arg0.getData();
		Object obj=data.get("fecha1");
		String valorRecibido1 = (String)obj;
		Object obj2=data.get("fecha2");
		String valorRecibido2 = (String)obj2;
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Start executeDataEvent in DatosFacturaQueryFecha_Q_DATOTCUF_WG71");
				logger.logDebug("Valores Recibidos" + valorRecibido1 + " " + "2: " + valorRecibido2);
			}
			bliBuscarFacturaFechas.execute(arg0);
		} catch (Exception ex) {
			DesignerManagerException.handleException(arg1.getMessageManager(), ex, logger);
		}
		return arg0.getEntityList(DatosFactura.ENTITY_NAME).getDataList();
	}

}

