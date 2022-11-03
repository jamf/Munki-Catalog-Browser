Copyright 2022 DATA JAR LTD

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

# Munki-Catalog-Browser
<p align="center"><img src="/../assets/images/MunkiCatalogBrowserx1024.png" width="256" height="256"></p>

Munki Catalog Browser is an app which allows a local macOS admin to easily list items in your devices Munki catalogs as well as exporting to CSV.

# Usage
1. On a macOS device which has Munki installed & logged in as a member of the Administrators group, download the [latest version of Munki Catalog Browser](https://github.com/dataJAR/Munki-Catalog-Browser/releases/latest)
3. Choose to check for updates automatically or not:
<p align="center"><img src="/../assets/images/Screenshot%202019-11-09%2015.53.11.png" width="512"></p>
4. Munki Catalog Browser should now load showing a window listing details from the Munki catalog files locally within your Managed Installs directory. An error message will be shown if the user running Munki Catalog Browser is not a member of the Administrators group or otherwise cannot read the Munki catalogs.<p align="center"><img src="/../assets/images/Screenshot%202019-11-09%2014.31.49.png" width="512"></p>
5. Typing in the search bar will search across the catalog content, pressing CMD+R will refresh the list re-reading in your catalogs, CMD+E will export to CSV, with this export exporting the matches from any entered search criteria.
<p align="center"><img src="/../assets/images/Screenshot%202019-11-09%2013.59.20.png" width="512"></p>
