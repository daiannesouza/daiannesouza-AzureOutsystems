param(
  [Parameter(Mandatory=$true)]
  [string]$PythonEnv,
  [Parameter(Mandatory=$true)]
  [string]$ArtifactDir,
  [Parameter(Mandatory=$true)]
  [string]$RequirementsFile
)

Write-Host "Create Artifacts Folder"
if(Test-Path -Path $ArtifactDir) {
  Remove-Item –Path $ArtifactDir -Force
} 
New-Item -ItemType Directory -Path $ArtifactDir

Write-Host "Create Python Virtual environment"
python -m venv $PythonEnv --clear

Write-Host "Switch to Virtual Environment"
. .\$PythonEnv\Scripts\Activate.ps1

Write-Host "Installing wheel Package"
pip install -U wheel
Write-Host "Install OutSystems Pipeline Package"
pip install -U outsystems-pipeline

Write-Host "Leave the Virtual Environment for now"
deactivate