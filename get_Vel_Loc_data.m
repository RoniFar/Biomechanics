function[NewTable] = get_Vel_Loc_data(Table, GTable)
    NewTable1 = Table(:, {'LINEAR_ACC_X','LINEAR_ACC_Y','LINEAR_ACC_Z'});
    NewTable2 = table();
    NewTable2.Variables = integrate_vec(NewTable1.Variables, 1/100);
    NewTable2.Properties.VariableNames = {'LINEAR_ACC_VEL_X','LINEAR_ACC_VEL_Y','LINEAR_ACC_VEL_Z'};
    NewTable3 = table();
    NewTable3.Variables = integrate_vec(NewTable2.Variables, 1/100);
    NewTable3.Properties.VariableNames = {'LINEAR_ACC_LOC_X','LINEAR_ACC_LOC_Y','LINEAR_ACC_LOC_Z'};
    NewTable = [NewTable1, NewTable2, NewTable3];
end
