/*
 * Archivo: ClienteQuery_QV_DN57_WPJ49.java
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

package com.cobiscorp.cobis.frntn.customevents.impl.queryview.rowupdating;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowUpdating;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.api.managers.DesignerManagerException;
import com.cobiscorp.designer.bli.api.IBLIExecutor;

@Component
@Service({ IGridRowUpdating.class })
@Properties({ @Property(name = "queryView.id", value = "QV_DN57_WPJ49"),
 			  @Property(name = "queryView.controlId", value = "QV_DN57_WPJ49")})

public class ClienteQuery_QV_DN57_WPJ49 implements IGridRowUpdating {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(ClienteQuery_QV_DN57_WPJ49.class);

	@Reference(bind="setBliActualizarCliente",
			unbind="unsetBliActualizarCliente",
			cardinality=ReferenceCardinality.MANDATORY_UNARY,
			target="(bli.id=BLI4792_bli_actualizarcliente)")
	private IBLIExecutor bliActualizarCliente;
	
	public void setBliActualizarCliente(IBLIExecutor bliActualizarCliente) {
		this.bliActualizarCliente = bliActualizarCliente;
	}
	
	public void unsetBliActualizarCliente(IBLIExecutor bliActualizarCliente) {
		this.bliActualizarCliente = null;
	}
	
	@Override
	public void rowAction(DataEntity arg0, IGridRowActionEventArgs arg1) {
		// TODO Auto-generated method stub
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Start rowAction in ClienteQuery_QV_DN57_WPJ49");
				logger.logDebug("Ingreso a la opcion Actualizar");
			}
			bliActualizarCliente.execute(arg1.getDynamicRequest());
		} catch (Exception ex) {
			DesignerManagerException.handleException(arg1.getMessageManager(), ex, logger);
		}
	}

}

