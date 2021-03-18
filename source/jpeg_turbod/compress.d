module jpeg_turbod.compress;

import jpeg_turbod.libjpeg_turbo;

class Compressor
{
    private
    {
        tjhandle compressor;
        enum int rgbPixelSize = 3;
    }

    this()
    {
        compressor = tjInitCompress();
    }

    ~this()
    {
        tjDestroy(compressor);
    }

    final char[] errorInfo()
    {
        import std.string : fromStringz;

        return fromStringz(tjGetErrorStr2(compressor));
    }

    final bool compress(in ubyte[] pixels, ref ubyte[] jpeg, int width, int height, int quality = 80)
    in
    {
        assert(quality >= 0 && quality <= 100, "JPEG quality must be in the range [0, 100].");
    }
    do
    {
        int pitch = 0; // jpeg_turbo will comput the pitch using width and the pixel format.
        ulong jpegSize = pixels.length;
        ubyte* allocBuffer;

        allocBuffer = tjAlloc(cast(int) jpegSize);

        int result = tjCompress2(compressor, pixels.ptr, width, pitch, height, TJPF.TJPF_RGB,
                &(allocBuffer), &jpegSize, TJSAMP.TJSAMP_444, quality, TJFLAG_ACCURATEDCT);

        if (result == 0)
        {
            jpeg = allocBuffer[0 .. jpegSize];
            return true;
        }
        else
        {
            return false;
        }
    }
}
