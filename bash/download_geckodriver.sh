
set -e

version=$(curl -s -L -w "%{url_effective}\n" -o /dev/null https://github.com/mozilla/geckodriver/releases/latest | grep -oE '[0-9.]+$')

echo "Latest: $version"

download_link="https://github.com/mozilla/geckodriver/archive/refs/tags/v$version.zip"

echo "$download_link"

mkdir geckosource
cd geckosource
wget "$download_link"

unzip ./"v$version".zip

gecko_folder=$(find . -type d -name "*0" -print -quit)

echo "UNZIP_FOLDER:  $gecko_folder"

cd "$gecko_folder"
echo "$gecko_folder"

cargo build --release

executable_geckodriver=$(find ./target/release -maxdepth 1 -type f -executable)

#Two step up where your .sh placed
cp "$executable_geckodriver" ./../../geckodriver

cd ./../..
ls
rm -r geckosource
