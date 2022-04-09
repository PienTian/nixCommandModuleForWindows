$ErrorActionPreference = "Stop"

Function Su{
    start-process PowerShell -Verb RunAs
}

Function Touch
{

    [CmdletBinding(PositionalBinding=$false)]
    param(
        [parameter(Mandatory=$false,position=0,ValueFromRemainingArguments)]
        [Alias('f')]
        [String[]] $FileName,

        [parameter(Mandatory=$false)]
        [Alias('a')]
        [switch] $Access,
        
        [parameter(Mandatory=$false)]
        [Alias('m')]
        [switch] $Write,
        
        [Parameter(Mandatory=$false)]
        [Alias('c')]
        [switch] $Create,

        [parameter(Mandatory=$false)]
        [Alias('t')]
        [DateTime] $DateTime,

        [parameter()]
        [Alias('v')]
        [switch]$Version,
        
        [parameter()]
        [Alias('h')]
        [switch]$Help
    )
    Begin
    {
         if ($Version){ 
              echo "version 1.0 touch mimic. Created by Pien: https://github.com/PienTian"
              return
         } 
         if ($Help){
$HelpText=@'
Touch command for windos v1.0.
-f -FileName <fileName> : specifies a file you want to create or modify timestamp
-a -Access : change timestamp of last access.
-m -Write : change timestamp of last write.
-c -create : change timestamp of creation.
-t -DateTime : specifies Datetime you want to change to. Object type is System.DateTime
-v -Version : shows version
-h -Help : shows this help.

Example:
     create eg1,eg2,eg3 file:  touch eg1 eg2 eg3
     change creation time and access time of eg1 simultaneously : touch eg1 -a -c -t "2019-01-01 19:24:33"
     change write time of eg2 at 2019/02/02 12:00AM: touch eg2 -t 02-02-2019 -w
'@

              Write-Host $HelpText
               return
         }
  
         if(-not $FileName){ 
             if(-not $1){throw "Argument is not set"} 
             $FileName = $args
         }
     }
     Process
     {
        foreach($file in $FileName){
              $isFileExists = Test-Path $file
              if(-not $isFileExists){
                   if(-not ($DateTime -or $Access -or $Create -or $Write)){
                   }else{throw "File can't be loaded. File does NOT EXIST and/or wrong format of command."}
                   New-Item $file
                   $obj = get-Item $file
              }else{
                   if(-not ($DateTime -or $Access -or $Create -or $Write)){throw "File Already Exists."}
                   $obj = Get-Item $file
                   if(-not $DateTime){throw "parameter is not set correctrly. Identify datetime with parameter -t."}
              }
              if($Access){
                   Write-Host "$file LastAccessTime" $obj.LastAccessTime "is modified to " -NoNewLine 
                   $obj.LastAccessTime = $DateTime
                   Write-Host $obj.LastAccessTime              
              }
              if($Write){
                   Write-Host "$file LastWriteTime" $obj.LastWriteTime "is modified to " -NoNewLine 
                   $obj.LastWriteTime = $DateTime
                   Write-Host $obj.LastWriteTime 
              }
              if($Create){
                   Write-Host "$file CreationTime" $obj.CreationTime "is modified to " -NoNewLine
                   $obj.CreationTime = $DateTime
                   Write-Host $obj.CreationTime
              }
              Select-Object -InputObject $obj -Property DirectoryName,name,CreationTime,LastAccessTime,LastWriteTime,Attributes
          }
      }
}





Export-ModuleMember -Function 'Su', 'Touch'
             