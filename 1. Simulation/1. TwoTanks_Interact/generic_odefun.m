function dxdtbc=generic_odefun(t, ProcessState, ControlState, M)
	
	Measurements = M.Process.OutputEq(t,ProcessState); %D=0
	dControllerStatedt = M.Controller.StateEq(t, ControlState, Measurements);
	u = M.Controller.OutputEq(t, ControlState, Measurements);
	dSProcesStatedt = M.Process.StateEq(t, ProcessState, u);
	dxdtbc=[dSProcesStatedt; dControllerStatedt];
end

