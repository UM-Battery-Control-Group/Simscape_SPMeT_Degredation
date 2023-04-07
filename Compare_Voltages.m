V_terminal = out.V_terminal_simscape(:);
Pybamm_Vt = PybammSPMesolution.TerminalVoltageV;
time = PybammSPMesolution.Times;
time_1 = out.Vterminal_Simscape.Time;
plot(time,Pybamm_Vt,"-",LineWidth=2);
hold on
plot(time,Vt,'-',LineWidth=2);
figure(1)
plot(out.Vterminal_Simscape.Time,V_terminal,':',LineWidth=2);
legend('Pybamm','Sravan','Simscape');
xlabel("Time [s]")
ylabel("Terminal Voltage")
hold off

Eta_n_Pybamm = PybammSPMesolution.XaveragedNegativeElectrodeReactionOverpotentialV;
Eta_p_Pybamm = PybammSPMesolution.XaveragedPositiveElectrodeReactionOverpotentialV;
Eta_p_Simscape = out.Eta_p_Simscape(:);
Eta_n_Simscape = out.Eta_n_Simscape(:);
Eta_p_Sravan = out.Eta_p_Sravan(:);
Eta_n_Sravan = out.Eta_n_Sravan(:);

figure(2)
plot(time,Eta_n_Pybamm,LineWidth=2);
hold on 
plot(time_1,Eta_n_Sravan,LineWidth=2);
plot(time_1,Eta_n_Simscape,LineWidth=2);
legend('Pybamm','Sravan','Simscape')
ylabel("Eta_n");
hold off

figure(3)
plot(time,Eta_p_Pybamm,LineWidth=2);
hold on 
plot(time_1,Eta_p_Sravan,LineWidth=2);
plot(time_1,Eta_p_Simscape,LineWidth=2);
legend('Pybamm','Sravan','Simscape')
ylabel("Eta_p")
hold off

elec_ohmic_Pybamm = PybammSPMesolution.XaveragedElectrolyteOhmicLossesV;
elec_over_Pybamm = PybammSPMesolution.XaveragedElectrolyteOverpotentialV;
Phi_elec_Sravan = out.Phi_Electrolyte_Sravan;
Phi_elec_Simscape = out.Phi_electrolyte_Simscape(:);
eta_elec_Simscape = out.Eta_electrolyte_Simscape(:);

figure(4)
plot(time,elec_ohmic_Pybamm,LineWidth=2);
hold on 
plot(time_1,-Phi_elec_Simscape,LineWidth=2)
legend('Pybamm','Simscape')
ylabel("Electrolyte ohmic")
hold off

figure(10)
plot(time,elec_over_Pybamm,LineWidth=2);
hold on
plot(time_1,eta_elec_Simscape,LineWidth=2)
legend('Pybamm','Simscape')
ylabel("Electrolyte overpotential")

figure(11)
plot(time,elec_over_Pybamm+elec_ohmic_Pybamm,LineWidth=2);
hold on
plot(time_1,Phi_elec_Sravan,LineWidth=2);
plot(time_1,eta_elec_Simscape-Phi_elec_Simscape,LineWidth=2);
legend('Pybamm','Sravan','Simscape')
ylabel("Phi Electrolyte")

neg_electrode_ohm_Pybamm = PybammSPMesolution.XaveragedNegativeElectrodeOhmicLossesV;
pos_electrode_ohm_Pybamm = PybammSPMesolution.XaveragedPositiveElectrodeOhmicLossesV;
neg_electrode_ohm_Sravan = out.Vr_n_Sravan;
neg_electrode_ohm_Simscape = out.Vr_n_Simscape(:);
pos_electrode_ohm_Sravan = out.Vr_p_Sravan;
%pos_electrode_ohm_Simscape = out.Vr_p_Simscape(:);

figure(5)
plot(time,pos_electrode_ohm_Pybamm,LineWidth=2);
hold on 
plot(time_1,pos_electrode_ohm_Sravan,LineWidth=2);
%plot(time_1,pos_electrode_ohm_Simscape,LineWidth=2);
legend('Pybamm pos','Sravan pos')
ylabel("electrode ohmic pos")
hold off

figure(6)
plot(time,neg_electrode_ohm_Pybamm,LineWidth=2);
hold on 
plot(time_1,-neg_electrode_ohm_Sravan,LineWidth=2);
plot(time_1,-neg_electrode_ohm_Simscape,':',LineWidth=2);
legend('Pybamm','Sravan','Simscape')
ylabel("Neg electrode ohmic")
hold off

Ce_neg_Pybamm = PybammSPMesolution.XaveragedNegativeElectrolyteConcentrationmolm3;
Ce_pos_Pybamm = PybammSPMesolution.XaveragedPositiveElectrolyteConcentrationmolm3;
Ce_neg_Simscape = out.Ce_neg_Simscape(:);
Ce_pos_Simscape = out.Ce_pos_Simscape(:);
Ce_neg_Sravan = out.Ce_neg_Sravan(:);
Ce_pos_Sravan = out.Ce_pos_Sravan(:);

figure(7)
plot(time,Ce_neg_Pybamm,LineWidth=2);
hold on 
plot(time_1,Ce_neg_Sravan,LineWidth=2);
plot(time_1,Ce_neg_Simscape,LineWidth=2);
legend('Pybamm','Sravan','Simscape')
ylabel("Ce Negative");
hold off

figure(8)
plot(time,Ce_pos_Pybamm,LineWidth=2);
hold on 
plot(time_1,Ce_pos_Sravan,LineWidth=2);
plot(time_1,Ce_pos_Simscape,LineWidth=2);
legend('Pybamm','Sravan','Simscape')
ylabel("Ce Positive")
hold off

figure(12)
plot(time,elec_over_Pybamm+elec_ohmic_Pybamm+pos_electrode_ohm_Pybamm+neg_electrode_ohm_Pybamm,LineWidth=2);
hold on
plot(time_1,eta_elec_Simscape-Phi_elec_Simscape+pos_electrode_ohm_Sravan-neg_electrode_ohm_Simscape,LineWidth=2)
legend("Pybamm","Simscape")
ylabel("total potential losses")

V_ocp_Pybamm = PybammSPMesolution.XaveragedBatteryOpenCircuitVoltageV;
V_ocp_Sravan = out.Vocp_Sravan;
V_ocp_Simscape = out.Vocp_Simscape(:);
figure(13)
plot(time,V_ocp_Pybamm,LineWidth=2);
hold on
plot(time_1,V_ocp_Sravan,LineWidth=2);
plot(time_1,V_ocp_Simscape,LineWidth=2);
legend("Pybamm","Sravan","Simscape")
ylabel("V ocp")
hold off


figure(14)
plot(time,Pybamm_Vt,"-",LineWidth=2);
hold on
plot(time_1,V_ocp_Simscape+eta_elec_Simscape-Phi_elec_Simscape+pos_electrode_ohm_Sravan-neg_electrode_ohm_Simscape-Eta_n_Simscape+Eta_p_Simscape,LineWidth=2);
plot(time,V_ocp_Pybamm+elec_over_Pybamm+elec_ohmic_Pybamm+pos_electrode_ohm_Pybamm+neg_electrode_ohm_Pybamm-Eta_n_Pybamm+Eta_p_Pybamm,LineWidth=2);
plot(out.Vterminal_Simscape.Time,V_terminal,':',LineWidth=3);
plot(time,V_ocp_Pybamm+elec_over_Pybamm-Eta_n_Pybamm+Eta_p_Pybamm,":",LineWidth=3);
%plot(time_1,V_ocp_Simscape+eta_elec_Simscape-Eta_n_Simscape+Eta_p_Simscape,':',LineWidth=3);
legend('PybammVt',"Simscape & losses",'Pybamm & all losses',"SimscapeVt","Pybamm VTerminal without ohmic")
ylabel("Voltage")
hold off

figure(15)
plot(time,V_ocp_Pybamm+elec_over_Pybamm+elec_ohmic_Pybamm+pos_electrode_ohm_Pybamm+neg_electrode_ohm_Pybamm-Eta_n_Pybamm+Eta_p_Pybamm, LineWidth=2);
hold on 
plot(time_1,V_terminal,LineWidth=2);
hold off
legend("Pybamm","Simscape")
ylabel("Vterminal")
xlabel("time")
hold off