## cleantop.sh

TThis script is a robust utility for maintaining a clean workspace. It automatically sorts files from your **Desktop** into categorized subdirectories based on their file extensions, ensuring that your primary interface remains clutter-free.

---

### Key Features

* **Automated Categorization:** Intelligently routes files to specific folders:
    * **Videos:** `.mp4`, `.mkv`
    * **Photos:** `.jpg`, `.jpeg`, `.png`
    * **Documents:** `.txt`, `.odt`, `.pdf`
    * **Scripts/IaC:** `.sh`, `.c`, `.py`, `.tf`, `.yml`, `.yaml`
    * **Cleanup:** Anything that doesn't match the above goes here by default.
* **Collision Protection (Versioning):** If a file with the same name already exists in the destination, the script appends a unique timestamp (`YYYYMMDD_HHMMSS`) to the filename. This prevents data loss while keeping your file history intact.
* **Extension-Aware Renaming:** Correctly handles files with and without extensions (e.g., `README` vs `script.sh`) during the versioning process.
* **Safe Path Handling:** Uses `-print0` and null delimiters to safely process filenames containing spaces, newlines, or special characters.
* **Case-Insensitive Matching:** Treats `.JPG` and `.jpg` identically to ensure no files are missed.

---

### Prerequisites

* **Environment:** Linux or macOS with `bash`.
* **System Tools:** `find`, `mkdir`, `mv`, and `date` (standard in almost all distributions).

---

### Usage

1.  **Set Permissions:**
    Make the script executable:
    ```bash
    chmod +x cleantop.sh
    ```

2.  **Manual Execution:**
    Run it whenever your desktop gets messy:
    ```bash
    ./cleantop.sh
    ```

3.  **Scheduled Execution (Cron):**
    To automate the cleanup, add it to your crontab. For example, to run it every day at midnight:
    ```bash
    0 0 * * * /home/user/scripts/cleantop.sh
    ```

---

### Logic Summary

The script follows a simple but effective logic gate for every file found:

* **Step 1:** Ensure all destination directories exist (`mkdir -p`).
* **Step 2:** Identify the file type.
* **Step 3:** Check if the destination already has a file with that name.
* **Step 4:** Move the file (renaming it with a timestamp only if a conflict is detected).

---

> [!TIP]
> This script is particularly useful for **DevOps and Systems Engineers** who frequently download temporary Terraform logs, YAML manifests, or screenshots that clutter the desktop during active lab sessions.
