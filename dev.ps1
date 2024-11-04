# Configuration
$CONFIG = @{
    Mode = "deploy"    # Fresh start
    BuildImage = $true # New build
    ShowLogs = $true   # Monitor build
}

# Function definitions
function Update-ConfigFiles {
    Write-Host "Updating configuration files..."
    docker cp config/xrdp.ini kali-xfce:/etc/xrdp/
    docker cp config/startwm.sh kali-xfce:/etc/xrdp/
    docker cp scripts/startup.sh kali-xfce:/

    Write-Host "Setting permissions..."
    docker exec kali-xfce chmod 644 /etc/xrdp/xrdp.ini
    docker exec kali-xfce chmod 755 /etc/xrdp/startwm.sh
    docker exec kali-xfce chmod 755 /startup.sh
}

function Restart-Services {
    Write-Host "Restarting XRDP services..."
    docker exec kali-xfce killall -9 xrdp xrdp-sesman
    docker exec kali-xfce /startup.sh
}

function Show-Status {
    Write-Host "`nContainer Status:"
    docker ps | Select-String "kali-xfce"

    Write-Host "`nXRDP Processes:"
    docker exec kali-xfce pgrep xrdp
    docker exec kali-xfce pgrep xrdp-sesman
}

# Main execution
switch ($CONFIG.Mode) {
    "dev" {
        if ($CONFIG.BuildImage) {
            Write-Host "Development mode with rebuild..."
            docker-compose down
            docker-compose build
            docker-compose up -d
        } else {
            Write-Host "Development mode - updating configs..."
            Update-ConfigFiles
            Restart-Services
        }
    }
    "deploy" {
        Write-Host "Deployment mode..."
        docker-compose down
        docker system prune -f
        docker-compose up -d --build
    }
    "test" {
        Write-Host "Test mode..."
        docker-compose restart
        Start-Sleep -Seconds 5
    }
}

# Show status
Show-Status

# Show logs if enabled
if ($CONFIG.ShowLogs) {
    Write-Host "`nContainer Logs:"
    docker-compose logs -f
}