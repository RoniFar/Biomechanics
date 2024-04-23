function [newTable] = get_all_data(Table)
    Table_ACC = get_acc_data(Table);
    Table_GRAV = get_gravity_data(Table);
    Table_LINACC = get_LinAcc_data(Table, Table_GRAV);
    Table_Mag = get_magnetic_data(Table);
    Table_Or = get_orientation_data(Table);
    Table_Gyro = get_GYRO_data(Table);
    newTable = [Table_ACC, Table_GRAV, Table_LINACC, Table_Mag, Table_Or, Table_Gyro];
end



function [NewTable] = get_acc_data(Table)
    headers = Table.Properties.VariableNames;
    Acc_Labels = {};
    Acc_Description = {};
    count = 1;
    for i = 1:length(headers)
        if contains(headers{i}, 'ACCELEROMETER')
            Acc_Labels{count} = headers{i};
            Acc_Description{count} = Table.Properties.VariableDescriptions{i};
            count = count + 1;
        end
    end
    NewTable = Table(:, Acc_Labels);
    NewTable.Properties.VariableDescriptions = Acc_Description;
    NewTable.Properties.VariableNames = {'ACCELEROMETER_X','ACCELEROMETER_Y','ACCELEROMETER_Z'};

end


function [NewTable] = get_gravity_data(Table)
    headers = Table.Properties.VariableNames;
    Acc_Labels = {};
    Acc_Description = {};
    count = 1;
    for i = 1:length(headers)
        if contains(headers{i}, 'GRAVITY')
            Acc_Labels{count} = headers{i};
            Acc_Description{count} = Table.Properties.VariableDescriptions{i};
            count = count + 1;
        end
    end
    NewTable = Table(:, Acc_Labels);
    NewTable.Properties.VariableDescriptions = Acc_Description;
    NewTable.Properties.VariableNames = {'GRAVITY_X','GRAVITY_Y','GRAVITY_Z'};
  
end


function [NewTable] = get_magnetic_data(Table)
    headers = Table.Properties.VariableNames;
    Mag_Labels = {};
    Mag_Description = {};
    count = 1;
    for i = 1:length(headers)
        if contains(headers{i}, 'MAGNETIC')
            Mag_Labels{count} = headers{i};
            Mag_Description{count} = Table.Properties.VariableDescriptions{i};
            count = count + 1;
        end
    end
    NewTable = Table(:, Mag_Labels);
    NewTable.Properties.VariableDescriptions = Mag_Description;
    NewTable.Properties.VariableNames = {'MAGNETIC_X','MAGNETIC_Y','MAGNETIC_Z'};
end


function [NewTable] = get_orientation_data(Table)
    headers = Table.Properties.VariableNames;
    Or_Labels = {};
    Or_Description = {};
    count = 1;
    for i = 1:length(headers)
        if contains(headers{i}, 'ORIENTATION')
            Or_Labels{count} = headers{i};
            Or_Description{count} = Table.Properties.VariableDescriptions{i};
            count = count + 1;
        end
    end
    NewTable = Table(:, Or_Labels);
    NewTable.Properties.VariableDescriptions = Or_Description;
    NewTable.Properties.VariableNames = {'ORIENTATION_Z','ORIENTATION_X','ORIENTATION_Y', 'ORIENTATION_Loc'};
end



function [NewTable] = get_LinAcc_data(Table, GTable)
    headers = Table.Properties.VariableNames;
    Mag_Labels = {};
    Mag_Description = {};
    count = 1;
    for i = 1:length(headers)
        if contains(headers{i}, 'ACCELERATION')
            Mag_Labels{count} = headers{i};
            Mag_Description{count} = Table.Properties.VariableDescriptions{i};
            count = count + 1;
        end
    end
    NewTable1 = Table(:, Mag_Labels);
    NewTable1.Properties.VariableDescriptions = Mag_Description;
    NewTable1.Properties.VariableNames = {'LINEAR_ACC_X','LINEAR_ACC_Y','LINEAR_ACC_Z'};
    NewTable2 = table();
    NewTable2.Variables = integrate_vec(NewTable1.Variables, 1/100);
    NewTable2.Properties.VariableNames = {'LINEAR_ACC_VEL_X','LINEAR_ACC_VEL_Y','LINEAR_ACC_VEL_Z'};
    NewTable3 = table();
    NewTable3.Variables = integrate_vec(NewTable2.Variables, 1/100);
    NewTable3.Properties.VariableNames = {'LINEAR_ACC_LOC_X','LINEAR_ACC_LOC_Y','LINEAR_ACC_LOC_Z'};
    NewTable = [NewTable1, NewTable2, NewTable3];
end


function [NewTable] = get_GYRO_data(Table)
headers = Table.Properties.VariableNames;
Mag_Labels = {};
Mag_Description = {};
count = 1;
for i = 1:length(headers)
    if contains(headers{i}, 'GYROSCOPE')
        Mag_Labels{count} = headers{i};
        Mag_Description{count} = Table.Properties.VariableDescriptions{i};
        count = count + 1;
    end
end
NewTable = Table(:, Mag_Labels);
NewTable.Properties.VariableDescriptions = Mag_Description;
NewTable.Properties.VariableNames = {'GYROSCOPE_X','GYROSCOPE_Y','GYROSCOPE_Z'};
NewTable.Variables = rad2deg(NewTable.Variables);
end



