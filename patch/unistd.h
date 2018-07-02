#ifndef _UNISTD_H
#define _UNISTD_H

#ifdef _WIN64
typedef __int64 ssize_t;
#else
typedef __int32 ssize_t;
#endif

#endif