module jpeg_turbod.decompress;

import jpeg_turbod.libjpeg_turbo;

class Decompressor
{
    private
    {
        tjhandle decompressor;
        int width, height, jpegSubsamp, jpegColorspace;
        enum int rgbPixelSize = 3;
    }

    this()
    {
        decompressor = tjInitDecompress();
    }

    ~this()
    {
        tjDestroy(decompressor);
    }

    final char[] errorInfo()
    {
        import std.string : fromStringz;

        return fromStringz(tjGetErrorStr2(decompressor));
    }

    final bool decompress(in ubyte[] jpeg, ref ubyte[] pixels, out int width, out int height)
    {
        auto jpegLength = cast(int) jpeg.length;

        auto result = tjDecompressHeader3(decompressor, jpeg.ptr, jpegLength,
                &width, &height, &jpegSubsamp, &jpegColorspace);

        if (result == -1)
        {
            return false;
        }

        width = width;
        height = height;

        if (pixels.length != width * height * rgbPixelSize)
        {
            pixels.length = width * height * rgbPixelSize;
        }

        result = tjDecompress2(decompressor, jpeg.ptr, jpegLength, pixels.ptr,
                width, 0, height, TJPF.TJPF_RGB, TJFLAG_ACCURATEDCT);

        return result == 0;
    }
}
