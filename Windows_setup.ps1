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
write-host " H:::::::H     H:::::::H  UU:::::::::::::UU      YYYY:::::YYYY         L::::::::::::::::::::::LE::::::::::::::::::::E " -foregroundcolor "Blue"
write-host " H:::::::H     H:::::::H    UU:::::::::UU        Y:::::::::::Y         L::::::::::::::::::::::LE::::::::::::::::::::E " -foregroundcolor "Orange"
write-host " HHHHHHHHH     HHHHHHHHH      UUUUUUUUU          YYYYYYYYYYYYY         LLLLLLLLLLLLLLLLLLLLLLLLEEEEEEEEEEEEEEEEEEEEEE " -foregroundcolor "Orange"

# Set Wget Progress to Silent, Becuase it slows down Downloading by 50x
echo "Setting Wget Progress to Silent, Becuase it slows down Downloading by 50x`n"
$ProgressPreference = 'SilentlyContinue'

# Downloading & Install JDK-19
echo "`t`tDownnloading Java JDK-19 ...."
$jdk19='https://download.oracle.com/java/19/archive/jdk-19.0.2_windows-x64_bin.msi'
iwr -Uri $jdk19 -OutFile jdk-19.msi  -verbose
echo "`n`t`tJDK-19 Downloaded, lets start the Installation process"
start -wait jdk-19.msi

# Downloading Burp Suite Professional
echo "Downloading Burp Suite Pro"
$burp='https://portswigger-cdn.net/burp/releases/download?product=pro&version=2023.10.3.6&type=Jar' 
iwr -Uri $burp -OutFile Burp-Suite-Pro.jar -verbose


# Creating Burp.bat file with command for execution
Set-Content -Path $pwd\Burp1.bat -Value 'java --add-opens=java.desktop/javax.swing=ALL-UNNAMED--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:"loader.jar" -noverify -jar "Burp-Suite-Pro.jar"'
echo "Burp.bat to created"
start Burp.bat
