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

package com.cobiscorp.cobis.frntn.customevents.impl.queryview.afterleaveinlinerow;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IGridAfterLeaveInLineRow;
import com.cobiscorp.designer.api.customization.arguments.IGridAfterLeaveInLineRowEventArgs;
import com.cobiscorp.designer.api.managers.DesignerManagerException;

@Component
@Service({ IGridAfterLeaveInLineRow.class })
@Properties({ @Property(name = "queryView.id", value = "QV_DN57_WPJ49"),
 			  @Property(name = "queryView.controlId", value = "QV_DN57_WPJ49")})

public class ClienteQuery_QV_DN57_WPJ49 implements IGridAfterLeaveInLineRow {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(ClienteQuery_QV_DN57_WPJ49.class);

	@Override
	public void afterLeaveInLineRow(DynamicRequest arg0, IGridAfterLeaveInLineRowEventArgs arg1) {
		// TODO Auto-generated method stub
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Start afterLeaveInLineRow in ClienteQuery_QV_DN57_WPJ49");
			}
		} catch (Exception ex) {
			DesignerManagerException.handleException(arg1.getMessageManager(), ex, logger);
		}
	}

}

