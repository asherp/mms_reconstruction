pro crib_edr_fgm_gse_1, trange=trange, fgmdir=fgmdir

timespan, trange

ext='.txt'

; mms_load_fgm, level='l2', data_rate='srvy', probe=['1','2','3','4']
mms_load_fgm, level='l2', data_rate='brst', probe=['1','2','3','4']

mms_load_state,trange=trange, probe=['1','2','3','4']

tplot_names

tplot,['mms1_fgm_b_gse_*_l2','mms2_fgm_b_gse_*_l2','mms3_fgm_b_gse_*_l2','mms4_fgm_b_gse_*_l2']

; output FGM (magnetometers) data
tplot_ascii,'mms?_fgm_b_gse_*_l2', trange = trange, dir=fgmdir, ext=ext
; tplot_ascii,['mms1_fgm_b_gse_*_l2','mms2_fgm_b_gse_*_l2','mms3_fgm_b_gse_*_l2','mms4_fgm_b_gse_*_l2'], trange = trange, dir=fgmdir, ext=ext

; output spacecraft positions
tplot_ascii,'mms?_mec_r_gse', trange = trange, dir=fgmdir, ext=ext

end