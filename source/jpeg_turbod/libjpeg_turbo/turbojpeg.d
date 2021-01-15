module libjpeg_turbo.turbojpeg;

import core.stdc.config : c_ulong;

extern (System):
alias tjhandle = void*;

tjhandle tjInitDecompress();

int tjDecompressHeader3(tjhandle handle, const ubyte* jpegBuf, c_ulong jpegSize,
        int* width, int* height, int* jpegSubsamp, int* jpegColorspace);

int tjDecompress2(tjhandle handle, const ubyte* jpegBuf, c_ulong jpegSize,
        ubyte* dstBuf, int width, int pitch, int height, int pixelFormat, int flags);

int tjDestroy(tjhandle handle);

char* tjGetErrorStr2(tjhandle handle);

enum TJPF
{
    TJPF_RGB = 0
}

enum int TJFLAG_FASTDCT = 2048;

enum int TJFLAG_ACCURATEDCT = 4096;
