function [allTables2fit] = applyButterworthFilterTable(allTables2fit, n, cutoff)
    frame_rate = 100;
    for i = 1:length(allTables2fit)
        allTables2fit{i} = ButterworthFilter(allTables2fit{i}, n, cutoff, frame_rate);
    end
end

function [T2filt] = ButterworthFilter(T2filt, n, cutoff, frame_rate)
% applying on moment to.
    wn = cutoff / (frame_rate/2);      % frame rate = 100
    [b,a] = butter(n, wn);
    T2filt.ACCELEROMETER_X = filtfilt(b,a,T2filt.ACCELEROMETER_X')';
    T2filt.ACCELEROMETER_Y = filtfilt(b,a,T2filt.ACCELEROMETER_Y')';
    T2filt.ACCELEROMETER_Z = filtfilt(b,a,T2filt.ACCELEROMETER_Z')';
    T2filt.LINEAR_ACC_X = filtfilt(b,a,T2filt.LINEAR_ACC_X')';
    T2filt.LINEAR_ACC_Y = filtfilt(b,a,T2filt.LINEAR_ACC_Y')';
    T2filt.LINEAR_ACC_Z = filtfilt(b,a,T2filt.LINEAR_ACC_Z')';
    T2filt.GYROSCOPE_X = filtfilt(b,a,T2filt.GYROSCOPE_X')';
    T2filt.GYROSCOPE_Y = filtfilt(b,a,T2filt.GYROSCOPE_Y')';
    T2filt.GYROSCOPE_Z = filtfilt(b,a,T2filt.GYROSCOPE_Z')';
end