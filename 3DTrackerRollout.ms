rollout tracker3DRollout "3D Tracker Importer"
(
    local trackerFile = undefined

    button ui_btnOpenFile "Open File..." width:150 height:10
    label ui_lblFile "<No file>" width:150 height:10
    button ui_btnApply "Apply" width:100 height:10

    fn applyDataToObjs objList =
    (
        local fs = openFile trackerFile
        local frame = 0
        local m = 10
        while not eof fs do
        (
            local l = readline fs
            local values = filterString l ","

            with animate on
            (
                for obj in objList do
                (
                    /*at time frame obj.pos = [(values[1] as float) * m, (values[2] as float) * m, (values[3] as float) * m]*/
                    local mat = matrix3 1
                    preTranslate mat [(values[1] as float) * m, (values[2] as float) * m, (values[3] as float) * m]
                    preRotate mat (eulertoquat (eulerAngles (radToDeg (values[4] as float)) (radToDeg (values[5] as float)) (radToDeg (values[6] as float))))
                    at time frame obj.transform = mat
                )
            )

            frame += 1
        )
        close fs
    )

    on ui_btnOpenFile pressed do
    (
        local file = getOpenFileName \
            caption:"3D Tracker Data" \
            types:"*.txt"
        if file != undefined then
        (
            trackerFile = file
            ui_lblFile.text = filenameFromPath file
        )
    )

    on ui_btnApply pressed do
    (
        local selObjs = getCurrentSelection()
        applyDataToObjs selObjs
    )
)
