# jpeg-turbod
A D wrapper for libjpeg-turbo.

Currently working on MacOS and Windows. Linux compatibility pending.

## Requirements
 - libjpeg-turbo
   - Installation:
     - MacOS (via Homebrew): `brew install jpeg-turbo`
     - MacOS/Windows (via official installer): https://libjpeg-turbo.org/Documentation/OfficialBinaries
   
## Usage
First install via dub: `dub add jpeg-turbod`

Then use in your program like so:
```d
import std.file : read, write;
import std.stdio : writefln, writeln;

import jpeg_turbod;

void main()
{
    const auto jpegFile = "image-in.jpg";
    auto jpegInput = cast(ubyte[]) jpegFile.read;

    auto dc = new Decompressor();
    ubyte[] pixels;
    int width, height;
    bool decompressed = dc.decompress(jpegInput, pixels, width, height);

    if (decompressed)
    {
      writefln("JPEG dimensions: %s x %s", width, height);
      writefln("First pixel: [%s, %s, %s]", pixels[0], pixels[1], pixels[2]);   
    }
    else
    {
      dc.errorInfo.writeln;
      return;
    }

    auto c = new Compressor();
    ubyte[] jpegOutput;
    bool compressed = c.compress(pixels, jpegOutput, width, height, 90);
    if (compressed)
    {
      "image-out.jpg".write(jpegOutput);
    }
    else
    {
      c.errorInfo.writeln;
    }
}

```

During compilation dub will try to find libjpeg-turbo at the following locations (in addition to the default search locations for your linker):
 - On MacOS:
   - Homebrew path: `/usr/local/opt/jpeg-turbo/lib` 
   - Installer path: `/opt/libjpeg-turbo/lib`
 - On Windows:
   - Installer paths: `C:\libjpeg-turbo64\lib` & `C:\libjpeg-turbo\lib`


## Todo
 - Linux compatibility
 - Documentation
 - ~~Compression to JPEG~~
 - ~~Access to error information~~
 - Output of grayscale/B&W images