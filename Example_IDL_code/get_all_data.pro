trange = ['16 12 24 15 03 24', '16 12 24 15 03 25']
fgmdir='./FGM'; data output directory
sgmdir='./FGM_L3'; data output directory
edpdir='./EDP/'; data output directory
fpidir = './FPI/'

crib_edr_fgm_gse_1, trange=trange, fgmdir=fgmdir

mms_save_to_ascii_sgm_1, trange=trange, sgmdir=sgmdir

Efld_load_edp_gse_corrected_1, trange=trange, edpdir=edpdir

make_ascii_mms_fpi_fgm_l3_hase_gse_1, trange=trange, fpidir=fpidir

end