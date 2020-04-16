function [ps_db_toa] = Estimation_final(channel)
    BW = 20;
    L = 1;
    N = 8;
    K = 924;
    channel=channel.';
    C = (1/N)*(channel*channel');
    step_sample = 0.01;
    index_carrier = 0:(K-1);
    index_delay = -2:step_sample:(2-step_sample);
    grid_carrier = repmat(index_carrier, length(index_delay),1);
    grid = (grid_carrier).' .* index_delay;
    S_toa = exp((-1i*grid*2*pi)/K);
    [ps_db_toa] = MUSIC_opt(C, S_toa,3);
end