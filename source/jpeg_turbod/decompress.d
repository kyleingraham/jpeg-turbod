module jpeg_turbod.decompress;

import jpeg_turbod.libjpeg_turbo;

class Decompressor
{
    private
    {
        tjhandle decompressor_;
        int width_, height_, jpegSubsamp_, jpegColorspace_;
        enum int rgbPixelSize = 3;
    }

    this()
    {
        decompressor_ = tjInitDecompress();
    }

    ~this()
    {
        tjDestroy(decompressor_);
    }

    final void decompress(in ubyte[] jpeg, ref ubyte[] pixels, out int width, out int height)
    {
        auto jpegLength = cast(int) jpeg.length;

        auto result = tjDecompressHeader3(decompressor_, jpeg.ptr, jpegLength,
                &width_, &height_, &jpegSubsamp_, &jpegColorspace_);

        width = width_;
        height = height_;

        if (pixels.length != width_ * height_ * rgbPixelSize)
        {
            pixels.length = width_ * height_ * rgbPixelSize;
        }

        result = tjDecompress2(decompressor_, jpeg.ptr, jpegLength, pixels.ptr,
                width_, 0, height_, TJPF.TJPF_RGB, TJFLAG_ACCURATEDCT);
    }
}
