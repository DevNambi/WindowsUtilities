#Script variables. 
$7zCommand = "C:\7Zip\7za.exe" #location of the 7z command-line application
$sourceFolder = "D:\CompressionTests\Csv\*" #the source folder to compress
$destinationFileRoot = "D:\CompressionTests\Results\Csv-" #the root location and file name of the destination
	#the destination file root should be unique for each data set and each test run.
$LogFile = "D:\CompressionTests\ResultsLog.txt" #where to write the log

#this is an array (list) of hash tables. Each hash table has strings to store the format, options, file name ending, and test name.
#the file endings should each be unique
$optionsArray=@(  )
$optionsArray += @{"Format"="-t7z"; "Options"="-mx1 -m0=LZMA2 -mmt=8"; "FileEnding"="lzma2-fastest-mmt8.7z"; "Name"="7z LMZA2 fastest 8 threads"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx3 -m0=LZMA2 -mmt=8"; "FileEnding"="lzma2-fast-mmt8.7z"; "Name"="7z LMZA2 fast 8 threads"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx5 -m0=LZMA2 -mmt=8"; "FileEnding"="lzma2-mmt8.7z"; "Name"="7z LMZA2 default 8 threads"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx7 -m0=LZMA2 -mmt=8"; "FileEnding"="lzma2-max-mmt8.7z"; "Name"="7z LMZA2 max 8 threads"}

$optionsArray += @{"Format"="-t7z"; "Options"="-mx1 -m0=LZMA2 -mmt=4"; "FileEnding"="lzma2-fastest-mmt4.7z"; "Name"="7z LMZA2 fastest 4 threads"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx3 -m0=LZMA2 -mmt=4"; "FileEnding"="lzma2-fast-mmt4.7z"; "Name"="7z LMZA2 fast 4 threads"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx5 -m0=LZMA2 -mmt=4"; "FileEnding"="lzma2-mmt4.7z"; "Name"="7z LMZA2 default 4 threads"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx7 -m0=LZMA2 -mmt=4"; "FileEnding"="lzma2-max-mmt4.7z"; "Name"="7z LMZA2 max 4 threads"}

$optionsArray += @{"Format"="-t7z"; "Options"="-mx1"; "FileEnding"="lzma-fastest.7z"; "Name"="7z LMZA fastest"}
$optionsArray += @{"Format"="-t7z"; "Options"=""    ; "FileEnding"="lzma.7z"; "Name"="7z LMZA default"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx3"; "FileEnding"="lzma-fast.7z"; "Name"="7z LMZA fast"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx7"; "FileEnding"="lzma-max.7z"; "Name"="7z LMZA max"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx9"; "FileEnding"="lzma-ultra.7z"; "Name"="7z LMZA ultra"}

$optionsArray += @{"Format"="-tzip"; "Options"="-mx5 -mmt=4"; "FileEnding"="zip.zip"; "Name"="ZIP default"}
$optionsArray += @{"Format"="-tzip"; "Options"="-mx7 -mmt=4"; "FileEnding"="zip-max.zip"; "Name"="ZIP max"}
$optionsArray += @{"Format"="-tzip"; "Options"="-mx9 -mmt=4"; "FileEnding"="zip-ultra.zip"; "Name"="ZIP ultra"}

$optionsArray += @{"Format"="-tbzip2"; "Options"="-mx1 -mmt=4"; "FileEnding"="bzip-fastest.bzip"; "Name"="BZIP2 fastest"}
$optionsArray += @{"Format"="-tbzip2"; "Options"="-mx3 -mmt=4"; "FileEnding"="bzip-fast.bzip"; "Name"="BZIP2 fast"}
$optionsArray += @{"Format"="-tbzip2"; "Options"="-mx5 -mmt=4"; "FileEnding"="bzip.bzip"; "Name"="BZIP2 default"}
$optionsArray += @{"Format"="-tbzip2"; "Options"="-mx7 -mmt=4"; "FileEnding"="bzip-max.bzip"; "Name"="BZIP2 max"}
$optionsArray += @{"Format"="-tbzip2"; "Options"="-mx9 -mmt=4"; "FileEnding"="bzip-ultra.bzip"; "Name"="BZIP2 ultra"}


$optionsArray += @{"Format"="-t7z"; "Options"="-mx1 -m0=PPMd"; "FileEnding"="ppmd-fastest.7z"; "Name"="7z PPMd fastest"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx3 -m0=PPMd"; "FileEnding"="ppmd-fast.7z"; "Name"="7z PPMd fast"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx5 -m0=PPMd"; "FileEnding"="ppmd.7z"; "Name"="7z PPMd default"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx7 -m0=PPMd"; "FileEnding"="ppmd-max.7z"; "Name"="7z PPMd max"}
$optionsArray += @{"Format"="-t7z"; "Options"="-mx9 -m0=PPMd"; "FileEnding"="ppmd-ultra.7z"; "Name"="7z PPMd ultra"}


#for each option, run a command to compress them. Log the start and end time, down to the second, in the log.
$optionsArray | Foreach-Object {
    $currentDict = $_;

    $CommandToExecute = $7zCommand + " a "+$currentDict["Options"]+ " "+$destinationFileRoot+$currentDict["FileEnding"]+" "+$sourceFolder
    
    "Source|"+$SourceFolder+"|Running|"+$currentDict["Name"]+"|started|"+(Get-Date).ToString("hh:mm:ss.ffff")| Out-File -FilePath $LogFile -append

    Write-Host $CommandToExecute
    Invoke-Expression $CommandToExecute

    "Source|"+$SourceFolder+"|Running|"+$currentDict["Name"]+"|ended|"+(Get-Date).ToString("hh:mm:ss.ffff")| Out-File -FilePath $LogFile -append
}