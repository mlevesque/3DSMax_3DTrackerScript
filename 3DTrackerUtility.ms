filein "3DTrackerRollout.ms"

utility PhysicsWireGlobalController "3D Tracker Importer"
(
    button ui_btnOpenDialog "Open Dialog"

    on ui_btnOpenDialog pressed do
    (
        CreateDialog tracker3DRollout
    )
)
