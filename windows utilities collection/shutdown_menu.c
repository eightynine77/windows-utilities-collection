#include <windows.h>
#include <stdio.h>
#include <conio.h>

/***
=====================================================
made by: jebbidan. eightynine77 on github
this is the source code of the shutdown_menu.exe windows executable.

if you want, you can make this C file work on linux, mac and other OSes.
=====================================================
***/

// Function to acquire the necessary privileges to shut down or restart Windows
BOOL EnableShutdownPrivilege() {
    HANDLE hToken;
    TOKEN_PRIVILEGES tkp;

    // Open the current process token to adjust privileges
    if (!OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &hToken)) {
        return FALSE;
    }

    // Get the LUID for the shutdown privilege
    LookupPrivilegeValue(NULL, SE_SHUTDOWN_NAME, &tkp.Privileges[0].Luid);

    tkp.PrivilegeCount = 1;  // One privilege to set
    tkp.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED;

    // Apply the privilege to the process token
    AdjustTokenPrivileges(hToken, FALSE, &tkp, 0, (PTOKEN_PRIVILEGES)NULL, 0);

    // Check if it succeeded
    return (GetLastError() == ERROR_SUCCESS);
}

int main() {
    // Set the console window title
    SetConsoleTitle("shutdown menu.");

    // Request privileges before attempting power operations
    if (!EnableShutdownPrivilege()) {
        printf("Error: Could not acquire shutdown privileges. Please run as administrator if necessary.\n");
        printf("Press any key to exit...\n");
        _getch();
        return 1;
    }

    // Display the menu exactly as requested
    printf("choose your option:\n");
    printf("A) shutdown\n");
    printf("S) restart\n");
    printf("D) exit\n");

    // Loop until a valid key is pressed
    while (1) {
        // _getch() reads a single character from the console without echoing or requiring Enter
        int choice = _getch();

        if (choice == 'A' || choice == 'a') {
            // EWX_SHUTDOWN shuts down the system. EWX_FORCE forces applications to close.
            ExitWindowsEx(EWX_SHUTDOWN | EWX_FORCE, SHTDN_REASON_MAJOR_OTHER | SHTDN_REASON_MINOR_OTHER);
            break;
        }
        else if (choice == 'S' || choice == 's') {
            // EWX_REBOOT restarts the system.
            ExitWindowsEx(EWX_REBOOT | EWX_FORCE, SHTDN_REASON_MAJOR_OTHER | SHTDN_REASON_MINOR_OTHER);
            break;
        }
        else if (choice == 'D' || choice == 'd') {
            // Exit the program
            break;
        }
    }

    return 0;
}
