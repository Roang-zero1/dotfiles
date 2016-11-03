REM Compare two excel files specified as parameters to this script
REM Example usage: excomp.bat Book1.xlsx Book2.xlsx

@ECHO OFF
@ECHO Comparing two files:
@ECHO 1: %1
@ECHO 2: %2

dir %1 /B /S > temp.txt
dir %2 /B /S >> temp.txt

"C:\Program Files (x86)\Microsoft Office\root\Office16\DCF\SPREADSHEETCOMPARE.EXE" temp.txt

del temp.txt