begin
        a = addfile("wrfout_d02_2016-01-01_00:00:00.nc","r")
        wks = gsn_open_wks("png","pw")
        pre = wrf_user_getvar(a,"pw",-1)
        max1 = max(pre)
        min1 = min(pre)
        time = wrf_user_getvar(a,"times",-1)
        times = dimsizes(time)
        t = wrf_user_list_times(a)
        
        res = True
        res@cnFillOn = True
        res@ContourParameters = (/min1,max1,2.0/)

        pltres = True
        pltres@PanelPlot = True

        mpres = True
        mpres@mpOutlineOn = False
        mpres@mpFillOn = False
  
        lnres = True
        lnres@gsLineColor = "gray"
        lnres@gsLineThicknessF = 0.5
        
        chn_shp_name = "/data/home/wangweiyi/shape/CHN_adm1.shp"

    do i = 0,times-1
         res@tiMainString = t(i)
         p = wrf_user_getvar(a,"pw",i)
         contour = wrf_contour(a,wks,p,res)
         plot = wrf_map_overlays(a,wks,contour,pltres,mpres)
         chn_id = gsn_add_shapefile_polylines(wks,plot,chn_shp_name,lnres)
         draw(plot)
         frame(wks)
end do
end         
          