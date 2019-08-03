#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <getopt.h>

#include "utils.h"
#include "des.h"


//#define DEBUG_ENABLE


// des mode
#define DES_MODE_DECRYPT    0x00U
#define DES_MODE_ENCRYPT    0x01U


// arguments parsing from terminal
#define FLAG_DECRYPT_MASK   0x01U
#define FLAG_ENCRYPT_MASK   0x02U
#define FLAG_DATA_MASK      0x04U
#define FLAG_KEY_MASK       0x08U

#define FLAG_DECRYPT_DATA_MASK  (FLAG_DECRYPT_MASK|FLAG_DATA_MASK|FLAG_KEY_MASK)
#define FLAG_ENCRYPT_DATA_MASK  (FLAG_ENCRYPT_MASK|FLAG_DATA_MASK|FLAG_KEY_MASK)
static unsigned char flag = 0;

static int decrypt = 0;
static int encrypt = 0;
static unsigned char data[8] = {0};
static unsigned char  key[8] = {0};


static void print_usage(const char *prog)
{
    printf("\n");
    printf("Usage: %s <-d|e> -k <key> <data>\n", prog);
    puts("  -d, --decrypt   decrypt data\n"
         "  -e, --encrypt   encrypt data\n"
         "  -h, --help      help information\n"
         "  -k, --key       key for decrypt or encrypt\n");
    printf("Examples:\n");
    printf("  destool -d -k 1122334455667788 1234567887654321\n");
    printf("  destool -e -k 1122334455667788 1234567887654321\n");
    printf("\n");
    exit(1);
}

static void parse_opts(int argc, char *argv[])
{
    int c;
    const struct option lopts[] = {
        { "decrypt", 0, 0, 'd' },
        { "encrypt", 0, 0, 'e' },
        { "help",    0, 0, 'h' },
        { "key",     1, 0, 'k' },
        { NULL, 0, 0, 0 },
    };

    while (1) {
        c = getopt_long(argc, argv, "dehk:", lopts, NULL);
        if (c == -1)
            break;

        switch (c) {
        case 'd':
            flag |= FLAG_DECRYPT_MASK;
            decrypt = 1;
            break;
        case 'e':
            flag |= FLAG_ENCRYPT_MASK;
            encrypt = 1;
            break;
        case 'k':
            flag |= FLAG_KEY_MASK;
            HexStringToByteArray(optarg, key, strlen(optarg));
            break;
        case 'h':
        default:
            print_usage(argv[0]);
            break;
        }
    }

    if (optind == argc - 1) {
        flag |= FLAG_DATA_MASK;
        HexStringToByteArray(argv[optind], data, strlen(argv[optind]));
    }

    if (flag != FLAG_DECRYPT_DATA_MASK && flag != FLAG_ENCRYPT_DATA_MASK) {
        print_usage(argv[0]);
    }
}

void print_buf_separator(const char *tips, unsigned char *buf, int len, const char *separator)
{
    int i;

    printf("%s: ", tips);
    printf("len = %d, ", len);
    printf("data = ");
    for (i = 0; i < len; i++) {
        printf("%02X", buf[i]);
        if (i != len -1) {
            printf("%s", separator);
        }
    }
    printf("\n");    
}

void print_buf(const char *tips, unsigned char *buf, int len)
{
    print_buf_separator(tips, buf, len, " ");
}


int main(int argc, char *argv[])
{
    int mode = 0;
    char *resultTips;
    unsigned char outBuffer[8] = {0};

    parse_opts(argc, argv);

#ifdef DEBUG_ENABLE
    // print the current arguments parsing result
    printf("decrypt = %d\n", decrypt);
    printf("encrypt = %d\n", encrypt);
    print_buf("data", data, 8);
    print_buf("key", key, 8);
#endif

    if (decrypt == 1) {
        mode = DES_MODE_DECRYPT;
        resultTips = "Decrypt result";
    }
    if (encrypt == 1) {
        mode = DES_MODE_ENCRYPT;
        resultTips = "Encrypt result";
    }

    printf("\n%s\n", resultTips);
    print_buf_separator("data  ", data, 8, "");
    print_buf_separator("key   ", key, 8, "");
    des(data, outBuffer, key, mode);
    print_buf_separator("output", outBuffer, 8, "");
    printf("\n");

    return 0;
}


