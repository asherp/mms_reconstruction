pro Efld_load_edp_gse_corrected_1, trange=trange, edpdir=edpdir

timespan, trange

data_rate='fast' ; fast or brst
level = 'l2'

probes=['1','2','3','4']

for i=0,n_elements(probes)-1 do begin
  mms_load_edp, trange=trange, level=level, probes=probes[i], data_rate=data_rate
  mms_load_state,probes=probes[i],datatypes=['spinras','spindec']

;  mms_cotrans,'mms'+probes[i]+'_edp_'+data_rate+'_dce',in_coord='dmpa',in_suffix='_dsl',out_coord='gsm',out_suffix='_gsm',/ignore_dlimits
  mms_qcotrans,'mms'+probes[i]+'_edp_dce_dsl_'+data_rate+'_'+level,in_coord='dsl',out_coord='gse',out_suffix='_gse',/ignore_dlimits

  get_data,'mms'+probes[i]+'_edp_dce_dsl_'+data_rate+'_'+level+'_gse',data=efield,limit=l,dlimit=dl
  e_shift = efield
  ts = time_struct(efield.x)
  e_shift.x = ts.sec + ts.fsec

  fileout='mms'+probes[i]+'_edp_dce_gse_'+data_rate+'_'+level
  store_data,fileout,data={x:efield.x,y:[[e_shift.x],[efield.y]]}
  tplot_ascii,fileout,trange = trange, dir=edpdir
  undefine,e_shift

endfor

tplot_names
tplot,['mms1_edp_dce_dsl_*','mms2_edp_dce_dsl_*','mms3_edp_dce_dsl_*','mms4_edp_dce_dsl_*']

end
