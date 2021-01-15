# jpeg-turbod
A D wrapper for libjpeg-turbo.

Currently working on MacOS. Windows and Linux compatibility pending.

## Requirements
 - libjpeg-turbo
   - Installation:
     - MacOS (via Homebrew): `brew install jpeg-turbo`
     - MacOS (via official installer): https://libjpeg-turbo.org/Documentation/OfficialBinaries
     
## Usage
First install jpeg-turbod via dub (instructions pending).

Then use in your program like so:
```d
import std.file;
import std.stdio;

import jpeg_turbod;

void main()
{
    const auto jpegFile = "image.jpg";
    auto jpeg = cast(ubyte[]) jpegFile.read;

    auto dc = new Decompressor();
    ubyte[] pixels;
    int width, height;
    dc.decompress(jpeg, pixels, width, height);

    writefln("JPEG dimensions: %s x %s", width, height);
    writefln("First pixel: [%s, %s, %s]", pixels[0], pixels[1], pixels[2]);
}

```

During compilation dub will try to find libjpeg-turbo at the following locations:
 - On MacOS:
   - Homebrew path: `/usr/local/opt/jpeg-turbo/lib` 
   - Installer path: `/opt/libjpeg-turbo/lib`
   

## Todo
 - Windows compatibility
 - Linux compatibility
 - Documentation
 - Access to error information
 - Output of grayscale/B&W images