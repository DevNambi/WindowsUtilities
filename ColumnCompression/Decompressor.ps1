#Script variables. 
$7zCommand = "C:\7Zip\7za.exe" #location of the 7z command-line application
$sourceFolder = "D:\CompressionTests\Results" #the source folder to compress
$targetFolder = "D:\CompressionTests\DecompressionResults\" #the folder containing all of the 
$LogFile = "D:\CompressionTests\DecompressionLog.txt" #where to write the log


#list all files in a folder, and decompress each one. 
Get-ChildItem $sourceFolder | Foreach-Object {
    $FileName = $_.FullName;
    $Term = $_.BaseName;
    $FolderToDecompress = $targetFolder + $Term

    #If there is not a folder for each file to decompress, create it
    if (-not (Test-Path $FolderToDecompress))
    {
        New-Item -ItemType directory -path $FolderToDecompress
    }

    $CommandToExecute = $7zCommand + " e "+$FileName +" -o"+$FolderToDecompress
    
    "Source|"+$Term+"|started|"+(Get-Date).ToString("hh:mm:ss.ffff")| Out-File -FilePath $LogFile -append

    Write-Host $CommandToExecute
    Invoke-Expression $CommandToExecute

    "Source|"+$Term+"|ended|"+(Get-Date).ToString("hh:mm:ss.ffff")| Out-File -FilePath $LogFile -append
}