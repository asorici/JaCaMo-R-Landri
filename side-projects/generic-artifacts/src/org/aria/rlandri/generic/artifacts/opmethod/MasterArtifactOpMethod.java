package org.aria.rlandri.generic.artifacts.opmethod;

import java.lang.reflect.Method;
import java.util.Arrays;

import org.apache.log4j.Logger;
import org.aria.rlandri.generic.artifacts.Coordinator;

import cartago.CartagoException;

public class MasterArtifactOpMethod extends ValidatorArtifactOpMethod {

	private static final Logger logger = Logger
			.getLogger(MasterArtifactOpMethod.class);

	public MasterArtifactOpMethod(Coordinator coordinator, Method method,
			Method validatorMethod) {
		super(coordinator, method, validatorMethod);
	}

	public void exec(Object[] actualParams) throws Exception {
		String msgFmt = "%s: checking if master agent is executing with parameters %s";
		logger.debug(String.format(msgFmt, this, Arrays.toString(actualParams)));
		if (!coordinator.isRegisteredMasterAgent()) {
			String errFmt = "Only the prime agent can execute %s";
			throw new CartagoException(String.format(errFmt, this));
		}
		validate(coordinator, actualParams);
		super.exec(actualParams);
	}

}
