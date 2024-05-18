import chromedriver_autoinstaller
import shutil

# Check if the current version of chromedriver exists
# and if it doesn't exist, download it automatically,
# then add chromedriver to path
chromedriver_path = chromedriver_autoinstaller.install(path=".")
shutil.move(chromedriver_path, ".")  # type: ignore
