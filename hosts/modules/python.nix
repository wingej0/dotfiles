{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        # Python Environment
        (python3.withPackages (ps: with ps; [
        requests
        pip
        numpy
        pandas
        jupyterlab
        pymongo
        matplotlib
        matplotlib-venn
        gspread
        sqlalchemy
        pyodbc
        ]))
    ];
}