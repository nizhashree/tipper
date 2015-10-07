# Pre-work - *Tipper*

**Tipper** is a tip calculator application for iOS.

Submitted by: **NizhaShree**

Time spent: **12** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.


The following **additional** features are implemented:

* [x] Rounding Off feature is added. This helps the user to round off the final amount to an +x amount max for paying easily. This information is also persisted
* [x] The settings page has the iphone settings page format with the selected default tip percentage / round off value displayed next to each setting
* [x] Sharing feature is added. This feature is not persisted as it is a one time feature always. Sharing feature opens a new view controller with the scroll feature to select number of members. It even has a pop-up to select number of members if the count is greater than 5.
* [x] The main page shows the initial amount, Tip value along with tip percentage selected , Round off value along with default Round off value, Sharing count (if not selected, it is displayed as none), total amount and amount per person ( in case of sharing count > 1 alone.)
* [x] The default tip percentage view has options listed as a table with a tick mark on the right end showing the current selection. Same goes for rounding off too
* [x] Currency symbol is prepended automatically after entering initial amount.
* [x] Truncating of bill amount to 2 decimals is also done

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/tYDBMiI.gif' title='Video Walkthrough' width='200' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

The challenge I faced was finalizing a design for the tipper to present all features in an easier way.


## License

    Copyright [2015] [nizhashree]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.