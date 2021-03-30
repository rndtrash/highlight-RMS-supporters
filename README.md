# Highlight RMS supporters

This User CSS highlights based chads who have signed the [RMS Support letter](https://github.com/rms-support-letter/rms-support-letter.github.io)
and not-so-based peeps who have signed the [RMS Open letter](https://github.com/rms-open-letter/rms-open-letter.github.io)

![image](https://user-images.githubusercontent.com/6745157/112768316-36f23f00-9024-11eb-84cd-ccd598ed20fc.png)

Collecting data of peeps who signed the support letter is bad, so you have to [build it by yourself](#building).

The stylesheet is rather large (~75kb) but your browser should cache it after one transfer so it's not a big deal.

Commits and PRs are very welcome :)

Thanks to [@sowa705](https://github.com/sowa705) for support and open letter scrapper :^)

## Building

1. Install Python version 3 or above
2. Install the dependencies of this project:

`pip install -r requirements.txt`

3. Run `make clean && make`
4. Done! Now import `rms-supporters-haters-highlighter.user.css` in any User Style extension you like!

## License

License under GPLv3 
