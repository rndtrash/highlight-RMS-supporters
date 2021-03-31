# RMS Supporters/Haters Highlighter

This User CSS highlights based chads who have signed the [RMS Support letter](https://github.com/rms-support-letter/rms-support-letter.github.io)
and not-so-based peeps who have signed the [RMS Open letter](https://github.com/rms-open-letter/rms-open-letter.github.io)

![image](https://user-images.githubusercontent.com/6745157/112768316-36f23f00-9024-11eb-84cd-ccd598ed20fc.png)

Pre-built CSS should be in [Releases](https://github.com/rndtrash/rms-supporters-haters-highlighter/releases) tab, but collecting and publishing data of peeps who signed the support letter is bad,
so you might have to [build it by yourself](#building).

The stylesheet is rather large (~240kb) but your browser should cache it after one transfer so it's not a big deal.

Commits and PRs are very welcome :)

Thanks to [@sowa705](https://github.com/sowa705) for support and open letter scrapper :^)

## Versioning scheme

X.Y.Z (e.g. 1.0.9), where:

* X - major change in CSS generator
* Y - minor change in CSS generator
* Z - change in data
Numbers start from 0.

## Building

1. Install Python version 3 or above
2. Install the dependencies of this project:

`pip install -r requirements.txt`

3. Run `make clean && make`
Now you should have a file called `rms-supporters-haters-highlighter.user.css`!

## Installing

1. Follow the steps in [Building](#building) or download pre-built CSS from [Releases](https://github.com/rndtrash/rms-supporters-haters-highlighter/releases) tab
2. Install `Stylus` extension for Chromium-based browser or Firefox
3. Drag and drop `rms-supporters-haters-highlighter.user.css` to tabs panel
4. Follow the on-screen instructions

## License

License under GPLv3 
