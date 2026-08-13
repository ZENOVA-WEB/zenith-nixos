#!/usr/bin/env python3
import os
import sys
import re
import subprocess
import termios
import tty

def get_timezones():
    zones = []
    base_path = '/usr/share/zoneinfo'
    if not os.path.exists(base_path):
        return [
            "America/New_York", "America/Los_Angeles", "America/Chicago", "America/Denver",
            "Europe/London", "Europe/Paris", "Europe/Berlin", "Europe/Rome", "Europe/Madrid",
            "Asia/Karachi", "Asia/Kolkata", "Asia/Tokyo", "Asia/Shanghai", "Asia/Singapore",
            "Australia/Sydney", "Africa/Cairo", "Africa/Johannesburg", "UTC"
        ]
    
    for root, dirs, files in os.walk(base_path):
        for file in files:
            full_path = os.path.join(root, file)
            # Skip symlinks and special files/dirs
            if os.path.islink(full_path):
                continue
            rel_path = os.path.relpath(full_path, base_path)
            parts = rel_path.split('/')
            
            # Exclude non-timezone metadata directories
            if any(p in ['posix', 'right', 'SystemV', 'Etc', 'US'] for p in parts):
                continue
                
            regions = {'Africa', 'America', 'Antarctica', 'Arctic', 'Asia', 'Atlantic', 'Australia', 'Europe', 'Indian', 'Pacific'}
            if parts[0] in regions:
                zones.append(rel_path)
                
    return sorted(list(set(zones)))

def input_with_autocomplete(prompt, default="", suggestions=None):
    if suggestions is None:
        suggestions = []
    
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    
    buffer = ""
    try:
        tty.setraw(fd)
        while True:
            # Find the best match
            match = ""
            if buffer:
                for s in suggestions:
                    if s.lower().startswith(buffer.lower()):
                        match = s
                        break
            
            # Clear line and print prompt + current buffer
            sys.stdout.write("\r\033[K" + prompt + buffer)
            
            # Draw autocompleted suggestion in dim grey
            if match and len(match) > len(buffer):
                suggestion_suffix = match[len(buffer):]
                sys.stdout.write("\033[90m" + suggestion_suffix + "\033[0m")
                sys.stdout.write("\b" * len(suggestion_suffix))
            elif not buffer and default:
                sys.stdout.write("\033[90m" + default + "\033[0m")
                sys.stdout.write("\b" * len(default))
                
            sys.stdout.flush()
            
            # Read 1 byte
            ch = sys.stdin.read(1)
            
            if ch in ('\r', '\n'):
                if not buffer and default:
                    buffer = default
                elif match and buffer.lower() == match.lower():
                    buffer = match
                sys.stdout.write("\n")
                sys.stdout.flush()
                return buffer
            elif ch in ('\x7f', '\x08'):
                if len(buffer) > 0:
                    buffer = buffer[:-1]
            elif ch == '\t':
                if match:
                    buffer = match
            elif ch == '\x1b':
                # Handle arrow keys
                next1 = sys.stdin.read(1)
                next2 = sys.stdin.read(1)
                if next1 == '[':
                    if next2 == 'C':  # Right Arrow
                        if match:
                            buffer = match
            elif ord(ch) >= 32 and ord(ch) <= 126:
                buffer += ch
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

def main():
    print("=== Zenith NixOS Installer Configuration ===")
    
    # 1. Hardware Configuration Generation
    print("\n[1/3] Generating NixOS hardware configuration...")
    hardware_path = "hosts/desktop/hardware-configuration.nix"
    try:
        # Run nixos-generate-config --show-hardware-config
        cmd = ["sudo", "nixos-generate-config", "--show-hardware-config"]
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=True)
        
        # Ensure hosts/desktop directory exists
        os.makedirs(os.path.dirname(hardware_path), exist_ok=True)
        with open(hardware_path, "w") as f:
            f.write(result.stdout)
        print(f"✓ Replaced {hardware_path} with generated configuration.")
    except Exception as e:
        print(f"⚠️  Could not generate hardware configuration: {e}")
        print("Continuing with existing hardware-configuration.nix...")

    # 2. Variable Gathering
    print("\n[2/3] Please enter the installation variables (Press Tab or Right Arrow to autocomplete suggestions/defaults):")
    
    timezones = get_timezones()
    
    # Define suggestions for fields
    gpus = ["intel", "amd", "nvidia"]
    locales = ["en_US.UTF-8", "en_GB.UTF-8", "de_DE.UTF-8", "fr_FR.UTF-8"]
    layouts = ["us", "uk", "fr", "de", "es"]
    
    user = input_with_autocomplete("Username: ", default="zaeem")
    fullName = input_with_autocomplete("Full Name: ", default="zaeem")
    email = input_with_autocomplete("Email: ", default="zaeemali272@gmail.com")
    hostname = input_with_autocomplete("Hostname: ", default="V14")
    timeZone = input_with_autocomplete("Timezone/Country/City: ", default="Asia/Karachi", suggestions=timezones)
    locale = input_with_autocomplete("Locale: ", default="en_US.UTF-8", suggestions=locales)
    keyboardLayout = input_with_autocomplete("Keyboard Layout: ", default="us", suggestions=layouts)
    gpu = input_with_autocomplete("GPU (intel/amd/nvidia): ", default="intel", suggestions=gpus)
    
    # 3. Replacing variables in vars.nix
    print("\n[3/3] Updating vars.nix...")
    vars_path = "vars.nix"
    if not os.path.exists(vars_path):
        print(f"❌ Error: {vars_path} not found!")
        sys.exit(1)
        
    with open(vars_path, "r") as f:
        content = f.read()
        
    # Replace the values using regex
    replacements = {
        "user": user,
        "fullName": fullName,
        "email": email,
        "hostname": hostname,
        "timeZone": timeZone,
        "locale": locale,
        "keyboardLayout": keyboardLayout,
        "gpu": gpu
    }
    
    for var, val in replacements.items():
        # Match pattern: varName = "value";
        pattern = re.compile(rf'({var}\s*=\s*")[^"]*(";)')
        content = pattern.sub(rf'\g<1>{val}\g<2>', content)
        
    with open(vars_path, "w") as f:
        f.write(content)
        
    print("✓ Successfully updated vars.nix!")
    print("\nSetup complete. You can now build/switch configuration using install.sh.")

if __name__ == "__main__":
    main()
