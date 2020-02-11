pro make_ascii_mms_fpi_fgm_l3_hase_gse_1, trange=trange, fpidir=fpidir
timespan, trange

probe='*'

; produce fast-survey FPI & FGM data in GSE
; make_ascii_mms_fpi_fgm_l2_hase_kitamura,trange,fpidir=fpidir

; produce burst-mode FPI & FGM data in GSE

make_ascii_mms_fpi_fgm_l2_hase_kitamura_gse,trange,outdir=fpidir, /brst

; make_ascii_mms_fpi_fsm_l3_hase_kitamura_gse,trange,fpidir=fpidir, /brst

end
