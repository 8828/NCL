load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
       a = addfile("wrfout_d02_2016-01-01_00:00:00.nc","r")
       time = wrf_user_getvar(a,"times",-1)
       times = dimsizes(time)
       pre = wrf_user_getvar(a,"pw",-1)
       max1 = max(pre)
       min1 = min(pre) 
       wks = gsn_open_wks("pdf","precipitation")
       gsn_define_colormap(wks,"rainbow")
       res=True
       res@cnFillOn = True
       res@gsnSpreadColors = True
       res@cnLevelSelectionMode = "ManualLevels"
       res@cnMinLevelValF = min1
       res@cnMaxLevelValF = max1
       res@cnLevelSpacingF = 2.0
   do   i = 0,times-1
        pp = wrf_user_getvar(a,"pw",i)
        plot = gsn_csm_contour(wks,pp,res)
   end do
end    
       