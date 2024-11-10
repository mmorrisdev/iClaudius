iClaudius is an iMessage extension that uses the Anthropic Claude API to generate responses to texts as the Roman Emperor. 

The extension requires a Claude API key to function. To install it on a device an Apple Developer account is also required.

The iClaudius project demonstrates several components

* Using Swift UI in an iMessage extension by replacing the default Storyboard file
* Constructing a URL request with model selection and other parameters for use with the Anthropic API
* Basic prompt engineering to configure the response personality
* Calling asynchronous functions from within a Swift UI structure

There are some differences in scrolling within the iMessage window, if you're experiencing issues with this, test the Swift UI in a stand alone app first to ensure its functionality.

The UX is outlined below, click an image for the full size version.

<table style="width:1024px">
    <tr>
        <td style="width:25%">When installed on the device, go to iMessages and click the + sign to bring up the list of iMessage extensions.<br><br> Tap More to reveal the full list, and you will see iClaudius there.</td>
        <td style="width:25%"><img src="https://uplink.to/home/images/github/iClaudius_0.PNG" style="width:100%"></td>
        <td style="width:25%">Tap on the iClaudius icon to open the extension in your iMessages window</td>
        <td style="width:25%"><img src="https://uplink.to/home/images/github/iClaudius_1.PNG" style="width:100%"></td>
    </tr>
    <tr>
        <td style="width:25%">Copy the text message you want to respond to and paste it into the text field, or type in any text.</td>
        <td style="width:25%"><img src="https://uplink.to/home/images/github/iClaudius_2.PNG" style="width:100%"></td>
        <td style="width:25%">Select if you want a normal response or a response from Emporer Claudius. and press send.</td>
        <td style="width:25%"><img src="https://uplink.to/home/images/github/iClaudius_3.PNG" style="width:100%"></td>
    </tr>
    <tr>
        <td style="width:25%">The response text is automatically added to the clipboard.</td>
        <td style="width:25%"><img src="https://uplink.to/home/images/github/iClaudius_4.PNG" style="width:100%"></td>
        <td style="width:25%">Paste the response back in the main iMessage text field and press  Return to send.</td>
        <td style="width:25%"><img src="https://uplink.to/home/images/github/iClaudius_6.PNG" style="width:100%"></td>
    </tr>
</table>


Shield: [![CC BY-NC 4.0][cc-by-nc-shield]][cc-by-nc]

This work is licensed under a
[Creative Commons Attribution-NonCommercial 4.0 International License][cc-by-nc].

[![CC BY-NC 4.0][cc-by-nc-image]][cc-by-nc]

[cc-by-nc]: https://creativecommons.org/licenses/by-nc/4.0/
[cc-by-nc-image]: https://licensebuttons.net/l/by-nc/4.0/88x31.png
[cc-by-nc-shield]: https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg

** iClaudius is not affiliated or related to the "I, Claudius" book or TV series.

