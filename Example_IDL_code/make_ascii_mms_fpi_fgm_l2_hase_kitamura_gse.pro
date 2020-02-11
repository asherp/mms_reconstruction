;+
;EXAMPLE:
; MMS>  make_ascii_mms_fpi_fgm_l2_hase,['2015-09-01/08:00:00','2015-09-02/00:00:00'],probes=['1','2','3','4']
; MMS>  make_ascii_mms_fpi_fgm_l2_hase,['2015-09-01/08:00:00','2015-09-02/00:00:00'],probes=['1','2','3','4'],/brst
; 
; NOTES:
;     1) See the notes in mms_load_data for rules on the use of MMS data
;     2) The time is shifted to mark the middle of the fpi data interval
;     3) Information of version of the first fpi cdf files is shown in the file name,
;        if multiple fpi cdf files are loaded
;     4) The coordinate transformation of velocities and calculation of temperatures 
;        will be updated in future
;     5) This procedure is to subtract background count from FPI DIS CDF v3.3 data
; 
; OUTPUT FORMAT:
; time position-GSMX[km] -GSMY[km] -GSMZ[km] dfg-GSMX[nT] -GSMY[nT] -GSMZ[nT] dfg_Btotal[nT] density[/cm^-3] velocity-GSMX[km/s] -GSMY[km/s] -GSMZ[km/s] temperature-parallel[eV] -perpendicular[eV]
;-

pro make_ascii_mms_fpi_fgm_l2_hase_kitamura_gse,trange,probes=probes,brst=brst,no_load_fgm=no_load_fgm,no_load_fpi=no_load_fpi,$
                                    no_load_mec=no_load_mec,fpi_suffix=fpi_suffix,outdir=outdir,delete=delete,$
                                    no_update=no_update

  mms_init
  trange=time_double(trange)
  if not undefined(delete) then store_data,'*',/delete
  if undefined(brst) then data_rate='fast' else data_rate='brst'
  if undefined(brst) then fgm_data_rate='srvy' else fgm_data_rate='brst'
  if undefined(fpi_suffix) then fpi_suffix=''
  if undefined(probes) then probes=['1','2','3','4']
  if probes[0] eq '*' then probes=['1','2','3','4']
  probes=strcompress(probes,/remove_all)
  
  mp = 1.6726219E-27  ; proton mass
  pres_fac = mp*1E+6*1E+6*1E+9  ; conversion to nPa
  kb = 1.38064852E-23  ; Boltzmann constant
  eV = 11604.5250061657  ; Kelvin of 1 eV
  temp_fac = 1E-9/(1E+6*kb*eV)  ; conversion to eV

  for i=0,n_elements(probes)-1 do begin
    
    if undefined(no_load_fgm) then mms_load_fgm,trange=[trange[0]-600.d,trange[1]+600.d],instrument='fgm',probes=probes[i],data_rate=fgm_data_rate,level='l2',no_update=no_update,versions=fgm_versions
    if undefined(no_load_fpi) then mms_load_fpi,trange=trange,probes=probes[i],level='l2',data_rate=data_rate,datatype='des-moms',suffix=fpi_suffix,no_update=no_update,versions=des_versions,/center_measurement
    if undefined(no_load_fpi) then mms_load_fpi,trange=trange,probes=probes[i],level='l2',data_rate=data_rate,datatype='dis-moms',suffix=fpi_suffix,no_update=no_update,versions=dis_versions,/center_measurement
    if undefined(no_load_mec) then mms_load_mec,trange=[trange[0]-600.d,trange[1]+600.d],probes=probes[i],no_update=no_update,varformat=['mms'+probes[i]+'_mec_r_eci','mms'+probes[i]+'_mec_r_gse','mms'+probes[i]+'_mec_r_gsm','mms'+probes[i]+'_mec_L_vec']
    if undefined(brst) then inval=4.5d else inval=0.03d
    
    if undefined(des_versions) then begin
       if strlen(tnames('mms'+probes[i]+'_des_numberdensity_'+data_rate+fpi_suffix)) gt 0 then begin
         get_data,'mms'+probes[i]+'_des_numberdensity_'+data_rate+fpi_suffix,dlimit=dl
         versions_temp=stregex(dl.cdf.gatt.logical_file_id,'v([0-9]+)\.([0-9]+)\.([0-9])',/extract,/subexpr)
         des_versions=intarr(1,3)
         for i_version=0,2 do des_versions[0,i_version]=fix(versions_temp[i_version+1])
       endif else begin
         if strlen(tnames('mms'+probes[i]+'_des_numberdensity_dbcs_'+data_rate+fpi_suffix)) gt 0 then begin
           get_data,'mms'+probes[i]+'_des_numberdensity_dbcs_'+data_rate+fpi_suffix,dlimit=dl
           versions_temp=stregex(dl.cdf.gatt.logical_file_id,'v([0-9]+)\.([0-9]+)\.([0-9])',/extract,/subexpr)
           des_versions=intarr(1,3)
           for i_version=0,2 do des_versions[0,i_version]=fix(versions_temp[i_version+1])
         endif else begin
           print,'no DES data'
           print
           return
         endelse
       endelse
    endif
    if des_versions[0,0] gt 2 then trange_clip,'mms'+probes[i]+'_des_numberdensity_'+data_rate+fpi_suffix,trange[0],trange[1],newname='mms'+probes[i]+'_des_numberDensity_clip' else trange_clip,'mms'+probes[i]+'_des_numberdensity_dbcs_'+data_rate+fpi_suffix,trange[0],trange[1],newname='mms'+probes[i]+'_des_numberDensity_clip'
    get_data,'mms'+probes[i]+'_des_numberDensity_clip',data=e_density,dlimit=dl
    store_data,'mms'+probes[i]+'_des_numberDensity_clip',/delete
    store_data,'mms'+probes[i]+'_des_shifted_time',data={x:e_density.x,y:e_density.x}

    if des_versions[0,0] gt 2 then begin
    endif else begin
      join_vec,'mms'+probes[i]+'_des_bulk'+['x','y','z']+'_dbcs_'+data_rate+fpi_suffix,'mms'+probes[i]+'_des_bulkv_dbcs_'+data_rate+fpi_suffix
      mms_cotrans,'mms'+probes[i]+'_des_bulkv',in_coord='dmpa',in_suffix='_dbcs_'+data_rate+fpi_suffix,out_coord='gse',out_suffix='_gse_'+data_rate+fpi_suffix,/ignore_dlimits
    endelse
    trange_clip,'mms'+probes[i]+'_des_bulkv_gse_'+data_rate+fpi_suffix,trange[0],trange[1],newname='mms'+probes[i]+'_des_bulkv_clip'
    get_data,'mms'+probes[i]+'_des_bulkv_clip',data=ve
    store_data,'mms'+probes[i]+'_des_bulkv_clip',/delete
    
    if des_versions[0,0] le 2 and data_rate eq 'fast' then begin
      get_data,'mms'+probes[i]+'_des_tempxx_dbcs_'+data_rate+fpi_suffix,data=texx
      get_data,'mms'+probes[i]+'_des_tempyy_dbcs_'+data_rate+fpi_suffix,data=teyy
      get_data,'mms'+probes[i]+'_des_tempzz_dbcs_'+data_rate+fpi_suffix,data=tezz
      get_data,'mms'+probes[i]+'_des_tempxy_dbcs_'+data_rate+fpi_suffix,data=texy
      get_data,'mms'+probes[i]+'_des_tempxz_dbcs_'+data_rate+fpi_suffix,data=texz
      get_data,'mms'+probes[i]+'_des_tempyz_dbcs_'+data_rate+fpi_suffix,data=teyz

      store_data,'mms'+probes[i]+'te_tensor',data={x:texx.x,y:[[texx.y],[teyy.y],[tezz.y],[texy.y],[texz.y],[teyz.y]]}
      diag_t,'mms'+probes[i]+'te_tensor'
      get_data,'T_diag',data=t_diag
      store_data,'mms'+probes[i]+'_fpi_DEStempPerp',data={x:t_diag.x,y:(t_diag.y[*,1]+t_diag.y[*,2])/2.d}
      store_data,'mms'+probes[i]+'_fpi_DEStempPara',data={x:t_diag.x,y:t_diag.y[*,0]}
    endif else begin
      copy_data,'mms'+probes[i]+'_des_tempperp_'+data_rate+fpi_suffix,'mms'+probes[i]+'_fpi_DEStempPerp'
      copy_data,'mms'+probes[i]+'_des_temppara_'+data_rate+fpi_suffix,'mms'+probes[i]+'_fpi_DEStempPara'
    endelse
    trange_clip,'mms'+probes[i]+'_fpi_DEStempPara',trange[0],trange[1],newname='mms'+probes[i]+'_fpi_DEStempPara_clip'
    get_data,'mms'+probes[i]+'_fpi_DEStempPara_clip',data=Te_para
    store_data,'mms'+probes[i]+'_fpi_DEStempPara_clip',/delete
    trange_clip,'mms'+probes[i]+'_fpi_DEStempPerp',trange[0],trange[1],newname='mms'+probes[i]+'_fpi_DEStempPerp_clip'
    get_data,'mms'+probes[i]+'_fpi_DEStempPerp_clip',data=Te_perp
    store_data,'mms'+probes[i]+'_fpi_DEStempPerp_clip',/delete

    box_ave_mms,variable1='mms'+probes[i]+'_des_shifted_time',variable2='mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2',var2ave='mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2_ele',inval=inval
    get_data,'mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2_ele',data=Bvec

    tinterpol_mxn,'mms'+probes[i]+'_mec_r_gse','mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2_ele',newname='mms'+probes[i]+'_mec_r_gse_intpl_ele'
    get_data,'mms'+probes[i]+'_mec_r_gse_intpl_ele',data=pos_gse
    store_data,'mms'+probes[i]+'_mec_r_gse_intpl_ele',/delete

    fpiver='v'+strcompress(des_versions[0,0],/remove_all)+'.'+strcompress(des_versions[0,1],/remove_all)+'.'+strcompress(des_versions[0,2],/remove_all)
  ;  fileout='mms'+probes[i]+'_des_'+data_rate+'_l2_'+fpiver+'_'+time_string(trange[0],format=2,precision=-1)+'-'+time_string(trange[1],format=2,precision=-1)
    fileout='mms'+probes[i]+'_des_'+data_rate+'_l2'

    store_data,fileout,data={x:e_density.x,y:[[pos_gse.y],[Bvec.y],[e_density.y],[ve.y],[Te_para.y],[Te_perp.y]]}
    tplot_ascii,fileout,dir=outdir
    store_data,fileout,/delete
    undefine,pos_gse,e_density,ve,vdbcs,Te_para,Te_perp


    if undefined(brst) then inval=4.5d else inval=0.15d

    if undefined(dis_versions) then begin
      if strlen(tnames('mms'+probes[i]+'_dis_numberdensity_'+data_rate+fpi_suffix)) gt 0 then begin
        get_data,'mms'+probes[i]+'_dis_numberdensity_'+data_rate+fpi_suffix,dlimit=dl
        versions_temp=stregex(dl.cdf.gatt.logical_file_id,'v([0-9]+)\.([0-9]+)\.([0-9])',/extract,/subexpr)
        dis_versions=intarr(1,3)
        for i_version=0,2 do dis_versions[0,i_version]=fix(versions_temp[i_version+1])
      endif else begin
        if strlen(tnames('mms'+probes[i]+'_dis_numberdensity_dbcs_'+data_rate+fpi_suffix)) gt 0 then begin
          get_data,'mms'+probes[i]+'_dis_numberdensity_dbcs_'+data_rate+fpi_suffix,dlimit=dl
          versions_temp=stregex(dl.cdf.gatt.logical_file_id,'v([0-9]+)\.([0-9]+)\.([0-9])',/extract,/subexpr)
          dis_versions=intarr(1,3)
          for i_version=0,2 do dis_versions[0,i_version]=fix(versions_temp[i_version+1])
        endif else begin
          print,'no DIS data'
          print
          return
        endelse
      endelse
    endif
;     print, dis_versions[0,0]
    if dis_versions[0,0] gt 2 then time_clip,'mms'+probes[i]+'_dis_numberdensity_'+data_rate+fpi_suffix,trange[0],trange[1],newname='mms'+probes[i]+'_dis_numberDensity_clip' else trange_clip,'mms'+probes[i]+'_dis_numberdensity_dbcs_'+data_rate+fpi_suffix,trange[0],trange[1],newname='mms'+probes[i]+'_dis_numberDensity_clip'
    time_clip,'mms'+probes[i]+'_dis_numberdensity_bg_'+data_rate+fpi_suffix,trange[0],trange[1],newname='mms'+probes[i]+'_dis_numberDensity_bg_clip'
    get_data,'mms'+probes[i]+'_dis_numberDensity_clip',data=i_density,dlimit=dl
    get_data,'mms'+probes[i]+'_dis_numberDensity_bg_clip',data=i_density_bg,dlimit=dl
    i_density_l2 = i_density
    i_density.y = i_density_l2.y - i_density_bg.y
    store_data,'mms'+probes[i]+'_dis_numberDensity_clip',/delete
    store_data,'mms'+probes[i]+'_dis_numberDensity_bg_clip',/delete
    store_data,'mms'+probes[i]+'_dis_shifted_time',data={x:i_density.x,y:i_density.x}
    
    time_clip,'mms'+probes[i]+'_dis_bulkv_gse_'+data_rate+fpi_suffix,trange[0],trange[1],newname='mms'+probes[i]+'_dis_bulkv_clip'
    get_data,'mms'+probes[i]+'_dis_bulkv_clip',data=vi
    vi_l2 = vi
    vi.y[*,0] = i_density_l2.y*vi_l2.y[*,0]/i_density.y
    vi.y[*,1] = i_density_l2.y*vi_l2.y[*,1]/i_density.y
    vi.y[*,2] = i_density_l2.y*vi_l2.y[*,2]/i_density.y
    store_data,'mms'+probes[i]+'_dis_bulkv_corr_gse_'+data_rate+fpi_suffix,data={x:vi.x,y:vi.y}
    
    if dis_versions[0,0] gt 2 then begin
    endif else begin
      join_vec,'mms'+probes[i]+'_dis_bulk'+['x','y','z']+'_dbcs_'+data_rate+fpi_suffix,'mms'+probes[i]+'_dis_bulkv_dbcs_'+data_rate+fpi_suffix
      mms_cotrans,'mms'+probes[i]+'_dis_bulkv',in_coord='dmpa',in_suffix='_dbcs_'+data_rate+fpi_suffix,out_coord='gse',out_suffix='_gse_'+data_rate+fpi_suffix,/ignore_dlimits
    endelse

    time_clip,'mms'+probes[i]+'_dis_bulkv_corr_gse_'+data_rate+fpi_suffix,trange[0],trange[1],newname='mms'+probes[i]+'_dis_bulkv_clip'
    get_data,'mms'+probes[i]+'_dis_bulkv_clip',data=vi_gse
    store_data,'mms'+probes[i]+'_dis_bulkv_clip',/delete
    
    time_clip,'mms'+probes[i]+'_dis_prestensor_gse_'+data_rate+fpi_suffix,trange[0],trange[1],newname='mms'+probes[i]+'_dis_prestensor_clip'
    get_data,'mms'+probes[i]+'_dis_prestensor_clip',data=ptens,dlimit=dl
    ptens_l2 = ptens

    time_clip,'mms'+probes[i]+'_dis_pres_bg_'+data_rate+fpi_suffix,trange[0],trange[1],newname='mms'+probes[i]+'_dis_pres_bg_clip'
    get_data,'mms'+probes[i]+'_dis_pres_bg_clip',data=p_bg,dlimit=dl

    ptens.y[*,0,0] = ptens_l2.y[*,0,0] - p_bg.y + pres_fac*(i_density_l2.y*vi_l2.y[*,0]*vi_l2.y[*,0] - i_density.y*vi.y[*,0]*vi.y[*,0])
    ptens.y[*,0,1] = ptens_l2.y[*,0,1]          + pres_fac*(i_density_l2.y*vi_l2.y[*,0]*vi_l2.y[*,1] - i_density.y*vi.y[*,0]*vi.y[*,1])
    ptens.y[*,0,2] = ptens_l2.y[*,0,2]          + pres_fac*(i_density_l2.y*vi_l2.y[*,0]*vi_l2.y[*,2] - i_density.y*vi.y[*,0]*vi.y[*,2])
    ptens.y[*,1,0] = ptens_l2.y[*,1,0]          + pres_fac*(i_density_l2.y*vi_l2.y[*,1]*vi_l2.y[*,0] - i_density.y*vi.y[*,1]*vi.y[*,0])
    ptens.y[*,1,1] = ptens_l2.y[*,1,1] - p_bg.y + pres_fac*(i_density_l2.y*vi_l2.y[*,1]*vi_l2.y[*,1] - i_density.y*vi.y[*,1]*vi.y[*,1])
    ptens.y[*,1,2] = ptens_l2.y[*,1,2]          + pres_fac*(i_density_l2.y*vi_l2.y[*,1]*vi_l2.y[*,2] - i_density.y*vi.y[*,1]*vi.y[*,2])
    ptens.y[*,2,0] = ptens_l2.y[*,2,0]          + pres_fac*(i_density_l2.y*vi_l2.y[*,2]*vi_l2.y[*,0] - i_density.y*vi.y[*,2]*vi.y[*,0])
    ptens.y[*,2,1] = ptens_l2.y[*,2,1]          + pres_fac*(i_density_l2.y*vi_l2.y[*,2]*vi_l2.y[*,1] - i_density.y*vi.y[*,2]*vi.y[*,1])
    ptens.y[*,2,2] = ptens_l2.y[*,2,2] - p_bg.y + pres_fac*(i_density_l2.y*vi_l2.y[*,2]*vi_l2.y[*,2] - i_density.y*vi.y[*,2]*vi.y[*,2])
    ttens = ptens
    ttens.y[*,0,0] = temp_fac*ptens.y[*,0,0]/i_density.y
    ttens.y[*,0,1] = temp_fac*ptens.y[*,0,1]/i_density.y
    ttens.y[*,0,2] = temp_fac*ptens.y[*,0,2]/i_density.y
    ttens.y[*,1,0] = temp_fac*ptens.y[*,1,0]/i_density.y
    ttens.y[*,1,1] = temp_fac*ptens.y[*,1,1]/i_density.y
    ttens.y[*,1,2] = temp_fac*ptens.y[*,1,2]/i_density.y
    ttens.y[*,2,0] = temp_fac*ptens.y[*,2,0]/i_density.y
    ttens.y[*,2,1] = temp_fac*ptens.y[*,2,1]/i_density.y
    ttens.y[*,2,2] = temp_fac*ptens.y[*,2,2]/i_density.y
    
    box_ave_mms,variable1='mms'+probes[i]+'_dis_shifted_time',variable2='mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2',var2ave='mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2_ion',inval=inval
    get_data,'mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2_ion',data=Bgse
    
    i_fac = fltarr(n_elements(Bgse.x),3)
    j_fac = fltarr(n_elements(Bgse.x),3)
    k_fac = fltarr(n_elements(Bgse.x),3)
    j_fac[*,0] = 0.
    j_fac[*,1] = 1.0
    j_fac[*,2] = 0.

    k_mag = fltarr(n_elements(Bgse.x))
    k_mag = sqrt(Bgse.y[*,0]^2 + Bgse.y[*,1]^2 + Bgse.y[*,2]^2)
    k_fac[*,0] = Bgse.y[*,0]/k_mag
    k_fac[*,1] = Bgse.y[*,1]/k_mag
    k_fac[*,2] = Bgse.y[*,2]/k_mag
    i_fac[*,0] = j_fac[*,1]*k_fac[*,2] - j_fac[*,2]*k_fac[*,1]
    i_fac[*,1] = j_fac[*,2]*k_fac[*,0] - j_fac[*,0]*k_fac[*,2]
    i_fac[*,2] = j_fac[*,0]*k_fac[*,1] - j_fac[*,1]*k_fac[*,0]
    i_mag = fltarr(n_elements(Bgse.x))
    i_mag = sqrt(i_fac[*,0]^2 + i_fac[*,1]^2 + i_fac[*,2]^2)
    i_fac[*,0] = i_fac[*,0]/i_mag
    i_fac[*,1] = i_fac[*,1]/i_mag
    i_fac[*,2] = i_fac[*,2]/i_mag
    j_fac[*,0] = k_fac[*,1]*i_fac[*,2] - k_fac[*,2]*i_fac[*,1]
    j_fac[*,1] = k_fac[*,2]*i_fac[*,0] - k_fac[*,0]*i_fac[*,2]
    j_fac[*,2] = k_fac[*,0]*i_fac[*,1] - k_fac[*,1]*i_fac[*,0]
    
    Mgse = fltarr(3,3)
    Mfac0 = Mgse
    Mttens = Mgse
    Mttens_fac = Mgse
    ttens_fac = fltarr(n_elements(Bgse.x),3,3)
    for j=0,n_elements(Bgse.x)-1 do begin
      for k=0,2 do begin
        Mgse[k,0] = i_fac[j,k]
        Mgse[k,1] = j_fac[j,k]
        Mgse[k,2] = k_fac[j,k]
        Mttens[k,0] = ttens.y[j,k,0]
        Mttens[k,1] = ttens.y[j,k,1]
        Mttens[k,2] = ttens.y[j,k,2]
      endfor
      Mttens_fac = Mttens # Mgse
      for k=0,2 do begin
        for l=0,2 do begin
          ttens_fac[j,k,l] = Mttens_fac[k,l]
        endfor
      endfor
    endfor
    Ti_par = sqrt(ttens_fac[*,0,2]^2 + ttens_fac[*,1,2]^2 + ttens_fac[*,2,2]^2)
    Ti_per1 = sqrt(ttens_fac[*,0,0]^2 + ttens_fac[*,1,0]^2 + ttens_fac[*,2,0]^2)
    Ti_per2 = sqrt(ttens_fac[*,0,1]^2 + ttens_fac[*,1,1]^2 + ttens_fac[*,2,1]^2)
;    Ti_par = sqrt(ttens_fac[*,2,0]^2 + ttens_fac[*,2,1]^2 + ttens_fac[*,2,2]^2)
;    Ti_per1 = sqrt(ttens_fac[*,0,0]^2 + ttens_fac[*,0,1]^2 + ttens_fac[*,0,2]^2)
;    Ti_per2 = sqrt(ttens_fac[*,1,0]^2 + ttens_fac[*,1,1]^2 + ttens_fac[*,1,2]^2)
    Ti_per = 0.5*(Ti_per1 + Ti_per2)
    
    copy_data,'mms'+probes[i]+'_dis_tempperp_'+data_rate,'mms'+probes[i]+'_fpi_DIStempPerp'
    copy_data,'mms'+probes[i]+'_dis_temppara_'+data_rate,'mms'+probes[i]+'_fpi_DIStempPara'

    time_clip,'mms'+probes[i]+'_fpi_DIStempPara',trange[0],trange[1],newname='mms'+probes[i]+'_fpi_DIStempPara_clip'
    get_data,'mms'+probes[i]+'_fpi_DIStempPara_clip',data=Ti_para
    store_data,'mms'+probes[i]+'_fpi_DIStempPara_clip',/delete
    time_clip,'mms'+probes[i]+'_fpi_DIStempPerp',trange[0],trange[1],newname='mms'+probes[i]+'_fpi_DIStempPerp_clip'
    get_data,'mms'+probes[i]+'_fpi_DIStempPerp_clip',data=Ti_perp
    store_data,'mms'+probes[i]+'_fpi_DIStempPerp_clip',/delete
    
    if not undefined(brst) then begin
      box_ave_mms,variable1='mms'+probes[i]+'_dis_shifted_time',variable2='mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2',var2ave='mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2_ion',inval=inval
    endif else begin
      copy_data,'mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2_ele','mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2_ion'
    endelse
    get_data,'mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2_ion',data=Bvec

    tinterpol_mxn,'mms'+probes[i]+'_mec_r_gse','mms'+probes[i]+'_fgm_b_gse_'+fgm_data_rate+'_l2_ion',newname='mms'+probes[i]+'_mec_r_gse_intpl_ion'
    get_data,'mms'+probes[i]+'_mec_r_gse_intpl_ion',data=pos_gse
    store_data,'mms'+probes[i]+'_mec_r_gse_intpl_ion',/delete

    fpiver='v'+strcompress(dis_versions[0,0],/remove_all)+'.'+strcompress(dis_versions[0,1],/remove_all)+'.'+strcompress(dis_versions[0,2],/remove_all)
  ;  fileout='mms'+probes[i]+'_dis_'+data_rate+'_l2_'+fpiver+'_'+time_string(trange[0],format=2,precision=-1)+'-'+time_string(trange[1],format=2,precision=-1)
    fileout='mms'+probes[i]+'_dis_'+data_rate+'_l2'

    store_data,fileout,data={x:i_density.x,y:[[pos_gse.y],[Bvec.y],[i_density.y],[vi_gse.y],[Ti_par],[Ti_per]]}
    tplot_ascii,fileout,dir=outdir
    store_data,fileout,/delete
    undefine,pos_gse,i_density,vi,vdbcs,Ti_para,Ti_perp
    undefine,Bvec,vi_gse,Ti_par,Ti_per
    
  endfor

end