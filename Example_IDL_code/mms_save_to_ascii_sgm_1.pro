;+
; PROCEDURE:
;         mms_save_to_ascii
;         
; PURPOSE:
;         Crib sheet showing how to load some MMS data into tplot 
;         variables then save the variables to ASCII files
; 
;   
; $LastChangedBy: egrimes $
; $LastChangedDate: 2018-07-02 09:34:06 -0700 (Mon, 02 Jul 2018) $
; $LastChangedRevision: 25427 $
; $URL: svn+ssh://thmsvn@ambrosia.ssl.berkeley.edu/repos/spdsoft/trunk/projects/mms/examples/basic/mms_save_to_ascii.pro $
;-

pro mms_save_to_ascii_sgm_1, trange=trange, sgmdir=sgmdir
timespan, trange



; load some FSM data
mms_load_fsm, trange=trange, probes=[1, 2, 3, 4], /time_clip

; save all of the data in the tplot variables to individual files with the 
; filenames being the same as the tplot variable names (in your IDL working directory)
tplot_ascii, /precise, ['mms1_fsm_b_gse_brst_l3', 'mms2_fsm_b_gse_brst_l3', 'mms3_fsm_b_gse_brst_l3', 'mms4_fsm_b_gse_brst_l3'], dir=sgmdir, trange=trange

; use trange keyword to limit the output to a specific time range
; tplot_ascii, trange=trange, ['mms1_fsm_b_gse_brst_l3', 'mms2_fsm_b_gse_brst_l3', 'mms3_fsm_b_gse_brst_l3', 'mms4_fsm_b_gse_brst_l3']

; use fname to change the filename of the output file
; tplot_ascii, 'mms1_fsm_b_gse_brst_l3', fname='some_fsm_data'

end
