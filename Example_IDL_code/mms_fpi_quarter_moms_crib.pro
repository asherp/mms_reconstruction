
trange = ['16 12 09 09 03 54', '16 12 09 09 03 55']
timespan, trange
outdir='./FPI_quarter';

; dis-qmoms are 37.5ms
; des-qmoms are 7.5ms

mms_load_fpi, probes=[1, 2, 3, 4], datatype=['dis-qmoms', 'des-qmoms'], data_rate='brst', trange=trange

tplot_ascii, 'mms?_dis_numberdensity_brst', dir=outdir, /precise
tplot_ascii, 'mms?_dis_bulkv_gse_brst', dir=outdir, /precise
tplot_ascii, 'mms?_des_numberdensity_brst', dir=outdir, /precise
tplot_ascii, 'mms?_des_bulkv_gse_brst', dir=outdir, /precise
stop
end
