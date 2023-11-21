# Name is Important =))
write-host " HHHHHHHHH     HHHHHHHHHUUUUUUUU     UUUUUUUUYYYYYYY       YYYYYYY     LLLLLLLLLLL             EEEEEEEEEEEEEEEEEEEEEE " -foregroundcolor "Red"
write-host " H:::::::H     H:::::::HU::::::U     U::::::UY:::::Y       Y:::::Y     L:::::::::L             E::::::::::::::::::::E " -foregroundcolor "Red"
write-host " H:::::::H     H:::::::HU::::::U     U::::::UY:::::Y       Y:::::Y     L:::::::::L             E::::::::::::::::::::E " -foregroundcolor "Red"
write-host " HH::::::H     H::::::HHUU:::::U     U:::::UUY::::::Y     Y::::::Y     LL:::::::LL             EE::::::EEEEEEEEE::::E " -foregroundcolor "Yellow"
write-host "   H:::::H     H:::::H   U:::::U     U:::::U YYY:::::Y   Y:::::YYY       L:::::L                 E:::::E       EEEEEE " -foregroundcolor "Yellow"
write-host "   H:::::H     H:::::H   U:::::D     D:::::U    Y:::::Y Y:::::Y          L:::::L                 E:::::E              " -foregroundcolor "Yellow"
write-host "   H::::::HHHHH::::::H   U:::::D     D:::::U     Y:::::Y:::::Y           L:::::L                 E::::::EEEEEEEEEE    " -foregroundcolor "Green"
write-host "   H:::::::::::::::::H   U:::::D     D:::::U      Y:::::::::Y            L:::::L                 E:::::::::::::::E    " -foregroundcolor "Green"
write-host "   H:::::::::::::::::H   U:::::D     D:::::U       Y:::::::Y             L:::::L                 E:::::::::::::::E    " -foregroundcolor "Green"
write-host "   H::::::HHHHH::::::H   U:::::D     D:::::U        Y:::::Y              L:::::L                 E::::::EEEEEEEEEE    " -foregroundcolor "White"
write-host "   H:::::H     H:::::H   U:::::D     D:::::U        Y:::::Y              L:::::L                 E:::::E              " -foregroundcolor "White"
write-host "   H:::::H     H:::::H   U::::::U   U::::::U        Y:::::Y              L:::::L         LLLLLL  E:::::E       EEEEEE " -foregroundcolor "White"
write-host " HH::::::H     H::::::HH U:::::::UUU:::::::U        Y:::::Y            LL:::::::LLLLLLLLL:::::LEE::::::EEEEEEEE:::::E " -foregroundcolor "Blue"
write-host " H:::::::H     H:::::::H  UU:::::::::::::UU      YYYY:::::YYYY         L::::::::::::::::::::::LE::::::::::::::::::::E " -foregroundcolor "Blue
write-host " H:::::::H     H:::::::H    UU:::::::::UU        Y:::::::::::Y         L::::::::::::::::::::::LE::::::::::::::::::::E " -foregroundcolor "Orange"
write-host " HHHHHHHHH     HHHHHHHHH      UUUUUUUUU          YYYYYYYYYYYYY         LLLLLLLLLLLLLLLLLLLLLLLLEEEEEEEEEEEEEEEEEEEEEE " -foregroundcolor "Orange"

# Set Wget Progress to Silent, Becuase it slows down Downloading by 50x
echo "Setting Wget Progress to Silent, Becuase it slows down Downloading by 50x`n"
$ProgressPreference = 'SilentlyContinue'

# Check JDK-18 or 19 Availability or Download JDK-18 or 19
$jdk19 = Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java(TM) SE Development Kit 19*"
if (!($jdk19)){
    echo "`t`tDownnloading Java JDK-19 ...."
    wget "https://download.oracle.com/java/19/archive/jdk-19.0.2_windows-x64_bin.msi" -O jdk-19.msi  
    echo "`n`t`tJDK-19 Downloaded, lets start the Installation process"
    start -wait jdk-19.msi
}else{
    echo "Required JDK-19 is Installed"
    $jdk19
}

# Downloading Burp Suite Professional
echo "Downloading Burp Suite Pro"
iwr -Uri "https://portswigger-cdn.net/burp/releases/download?product=pro&version=2023.9.2&type=Jar" -OutFile Burp-Suite-Pro.jar -verbose


# Creating Burp.bat file with command for execution
if (Test-Path burp.bat) {rm burp.bat}
$path = "java --add-opens=java.desktop/javax.swing=ALL-UNNAMED--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:`"$pwd\loader.jar`" -noverify -jar `"$pwd\Burp-Suite-Pro.jar`""
$path | add-content -path Burp.bat
echo "`nBurp.bat file is created"


# Creating Burp-Suite-Pro.vbs File for background execution
if (Test-Path Burp-Suite-Pro.vbs) {
   Remove-Item Burp-Suite-Pro.vbs}
echo "Set WshShell = CreateObject(`"WScript.Shell`")" > Burp-Suite-Pro.vbs
add-content Burp-Suite-Pro.vbs "WshShell.Run chr(34) & `"$pwd\Burp.bat`" & Chr(34), 0"
add-content Burp-Suite-Pro.vbs "Set WshShell = Nothing"
echo "`nBurp-Suite-Pro.vbs file is created."

# Remove Additional files
rm Linux_setup.sh
del -Recurse -Force .\.github\


# Lets Activate Burp Suite Professional with keygenerator and Keyloader
echo "Reloading Environment Variables ...."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
echo "`n`nStarting Keygenerator ...."
start-process java.exe -argumentlist "-jar loader.jar"
echo "`n`nStarting Burp Suite Professional"
java --add-opens=java.desktop/javax.swing=ALL-UNNAMED--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:"loader.jar" -noverify -jar "Burp-Suite-Pro.jar"
