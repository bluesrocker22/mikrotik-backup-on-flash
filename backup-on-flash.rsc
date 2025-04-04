:local folder "backup"
:local mountPoint ""
:local backupPath ""
:local deviceId [/system identity get name]
:local currentDate [/system clock get date]
:local currentTime [/system clock get time]
:local formattedTime ([:pick $currentTime 0 2] . [:pick $currentTime 3 5] . [:pick $currentTime 6 8])

:foreach disk in=[/disk print as-value where mounted] do={
  :set mountPoint ($disk->"mount-point")
  :log debug "found mount point: $mountPoint"
  :local folderName ($mountPoint . "/" . $folder)
  
  :foreach file in=[/file print as-value where type=directory] do={
     :set backupPath ($file->"name")
     :if ($backupPath = $folderName) do={
            :log debug ("backup folder found: " . $backupPath)
            :local dailyBackupPath "$backupPath/$currentDate"

            :if ([/file print count-only where type=directory name=$dailyBackupPath] > 0) do={
                :log debug ("Folder already exists: " . $dailyBackupPath)
             } else={
                 /file add type=directory name="$dailyBackupPath"
                 :delay 2
                 :log debug ("Created folder: " . $dailyBackupPath)
             }

            :log info "Backup process has been started to $dailyBackupPath..."
            :local fileName "$dailyBackupPath/$deviceId_$currentDate_$formattedTime"
             /export show-sensitive file="$fileName"
             /system backup save dont-encrypt=yes name="$fileName"
             :log info ("Backups have been saved to " . $fileName . " (.backup and .rsc files)")
     }
  }
}
