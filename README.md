# BlurMate = TM2 + Alpha &rarr; Blur

![BlurMate](https://f.cloud.github.com/assets/4581/2430127/de1b7166-acba-11e3-9530-ea3527ad07ac.png)

A very quick and dirty TextMate 2 plugin that simply blurs the window background.  Useful if you have a theme with a transparent background, where otherwise it can make things pretty unreadable sometimes.

Inspired by BlurMate for TM1, for which the source code was never released.  I hijacked the name because, well, because.

## Installing

Simply grab the latest release and drop it in `~/Library/Application Support/TextMate/PlugIns` (create the folder if it doesn't exist already).  Double clicking to install doesn't work for some reason.  No biggie.

## Configuring

The default blur radius is 20.  I think it's pixels, but it could be hamsters for all I know.  You can change it to whatever you like using `defaults` like this:

`defaults write com.macromates.TextMate.preview BlurMateRadius <value>`

## Uninstalling

Just remove `BlurMate.tmplugin` from `~/Library/Application Support/TextMate/PlugIns`.

## Contributing

Pull requests are welcome.  Plagiarism welcome too.  It took me literally an hour to throw together, with a little code borrowed from iTerm2.  If you can make something better based on this then please feel free to do so and I'll happily use yours.
