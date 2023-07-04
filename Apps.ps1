Add-Type -TypeDefinition @"
using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.Windows.Forms;

public class ProgramInstallerForm : Form
{
    private Label label;
    private Button installButton;
    private Dictionary<string, List<string>> programCategories;
    private List<CheckBox> checkboxes;

    public ProgramInstallerForm()
    {
        this.Text = "Program Installer";
        this.Width = 400;
        this.Height = 300;
        this.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog;
        this.MaximizeBox = $false;

        // Initialize program categories
        programCategories = @{
            "Browsers" = @("Google Chrome", "Mozilla Firefox", "Microsoft Edge");
            "Gaming" = @("Steam", "Epic Games", "Origin");
        };

        // Create label
        label = New-Object Label;
        label.Location = New-Object Drawing.Point(10, 10);
        label.AutoSize = $true;
        label.Text = "Select the programs you want to install:";
        $this.Controls.Add(label);

        # Create checkboxes
        checkboxes = @();
        $y = 30;
        foreach ($category in $programCategories.Keys)
        {
            $categoryLabel = New-Object Label;
            $categoryLabel.Location = New-Object Drawing.Point(10, $y);
            $categoryLabel.AutoSize = $true;
            $categoryLabel.Text = $category;
            $this.Controls.Add($categoryLabel);
            $y += 20;

            foreach ($program in $programCategories[$category])
            {
                $checkbox = New-Object CheckBox;
                $checkbox.Location = New-Object Drawing.Point(30, $y);
                $checkbox.AutoSize = $true;
                $checkbox.Text = $program;
                $this.Controls.Add($checkbox);
                $checkboxes += $checkbox;
                $y += 20;
            }
        }

        # Create install button
        installButton = New-Object Button;
        installButton.Location = New-Object Drawing.Point(10, $y);
        installButton.Text = "Install";
        installButton.Add_Click({
            $selectedPrograms = $checkboxes | Where-Object { $_.Checked } | Select-Object -ExpandProperty Text
            foreach ($program in $selectedPrograms)
            {
                Write-Host "Installing program: $program"
                Start-Process "winget" -ArgumentList "install", $program -Wait -NoNewWindow
            }
            $this.Close()
        })
        $this.Controls.Add(installButton);
    }
}

$programInstallerForm = New-Object ProgramInstallerForm
$programInstallerForm.ShowDialog() | Out-Null
"@
