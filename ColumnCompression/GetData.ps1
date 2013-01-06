$GetQuery = "SELECT * FROM DataScience.[dbo].[training_data] ORDER BY ProjectID, MailID"
$FileLocation = "D:\Transfer2\Kaggle\CompressStart\Everything.txt"

$CommandToRun = 'bcp.exe "'+$GetQuery+'" queryout '+$FileLocation+' -c -T -S .'

Write-Host $CommandToRun

Invoke-Expression $CommandToRun

<#
[ProjectId]
,[MailId]
,[MailCodeId]
,[prospectid]
,[listid]
,[datemailed]
,[amount]
,[donated]
,[zip]
,[zip4]
,[VectorMajor]
,[VectorMinor]
,[packageid]
,[phase]
,[databaseid]
,[amount2]
#>