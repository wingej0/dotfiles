{ config, pkgs, ... }:
{
    # Enable cron jobs
    services.cron = {
        enable = true;
        systemCronJobs = [
        "20 15 * * * wingej0 python /home/wingej0/dev/alo/alo_updater.py"
        "0 16 * * * wingej0 /home/wingej0/dev/daily.sh"
        ];
    };
}