#include <stdio.h>
#include <errno.h>
#include <stdint.h>

#define _BYTE1(x) (  x        & 0xFF )
#define _BYTE2(x) ( (x >>  8) & 0xFF )
#define _BYTE3(x) ( (x >> 16) & 0xFF )
#define _BYTE4(x) ( (x >> 24) & 0xFF )
#define BYTE_SWAP_16(x) ((uint16_t)( _BYTE1(x)<<8 | _BYTE2(x) ))
#define BYTE_SWAP_32(x) ((uint32_t)( _BYTE1(x)<<24 | _BYTE2(x)<<16 | _BYTE3(x)<<8 | _BYTE4(x) ))


/* for SLD data stream */
typedef union {
  int i;
  float f;
  uint32_t u;
  uint8_t b[4];
} fi_union;


/* the binary image of the input SLD data */
#define MAX_N_WORDS 4096
fi_union sld_words[MAX_N_WORDS];
uint8_t sld_bytes[MAX_N_WORDS * 4];
unsigned sld_n_words = 0;
unsigned sld_n_bytes = 0;




/*****************************************************************************
 * SLD Reader : convert the input SLD text file into a binary format
 ****************************************************************************/

/*-----------------------------------------------------------------------------
 * read a float in the SLD file and append it to the array sld_words.
 * fp : input SLD file stream
 * RETURN value : the float read from the file
 */
static float read_float(FILE* fp)
{
  fi_union fi;
  float f;
  // fprintf(stderr,"   start read_float satrt\n");
  if(sld_n_words >= MAX_N_WORDS){
    // fprintf(stderr,"read_float : too many sld words.\n");
    return 0;
  }
  if(fscanf(fp, " %f", &(f)) != 1){
    fprintf(stderr,"failed to read a float\n");
    return 0;
  }else{
    // fprintf(stderr,"read %5f\n",f);
  }
  fi.f = f;
  sld_words[sld_n_words++].u = BYTE_SWAP_32(fi.u);
  sld_bytes[sld_n_bytes++] = fi.b[3];
  sld_bytes[sld_n_bytes++] = fi.b[2];
  sld_bytes[sld_n_bytes++] = fi.b[1];
  sld_bytes[sld_n_bytes++] = fi.b[0];
  // fprintf(stderr,"read_float, %f : %08x\n",f,fi.i);
  // for(int i = sld_n_bytes - 3; i <= sld_n_bytes;i++){
  //   fprintf(stderr,"%02x",sld_bytes[i]);
  // }
  // fprintf(stderr,"   start read_float finish\n");
  return f;
}

/*-----------------------------------------------------------------------------
 * read an integer in the SLD file and append it to the array sld_words.
 * fp : input SLD file stream
 * RETURN value : the integer read from the file
 */
static int read_int(FILE* fp)
{
  // fprintf(stderr,"   start read_int satrt\n");
  int i;
  fi_union fi;
  if(sld_n_words >= MAX_N_WORDS){
    // fprintf(stderr,"read_int : too many sld words.\n");
    return 0;
  }

  if(fscanf(fp, " %d", &i) != 1){
    fprintf(stderr,"failed to read an int\n");
    return 0;
  }else{
    // fprintf(stderr,"read %5d\n",i);
  }

  fi.i = i;
  sld_words[sld_n_words++].u = BYTE_SWAP_32(fi.u);
  sld_bytes[sld_n_bytes++] = fi.b[3];
  sld_bytes[sld_n_bytes++] = fi.b[2];
  sld_bytes[sld_n_bytes++] = fi.b[1];
  sld_bytes[sld_n_bytes++] = fi.b[0];
  // fprintf(stderr,"   start read_int end\n");
  return i;
}

/*-----------------------------------------------------------------------------
 * read a 3D float vector and append it to the array sld_words.
 * fp : input SLD file stream
 */
static void read_vec3(FILE* fp)
{
  // fprintf(stderr," start read_vec3 start\n");
  read_float(fp);
  read_float(fp);
  read_float(fp);
  // fprintf(stderr," start read_vec3 finish\n");
}

/*-----------------------------------------------------------------------------
 * read the scene environments
 * fp : input SLD file stream
 */
static void read_sld_env(FILE* fp)
{
  // fprintf(stderr,"start read_sld_start finish\n");
  /* screen pos */
  read_vec3(fp);
  /* screen rotation */
  read_float(fp);  read_float(fp); 
  /* n_lights : Actually, it should be an int value ! */
  read_float(fp);
  /* light rotation */
  read_float(fp);  read_float(fp);
  /* beam  */
  read_float(fp);
  // fprintf(stderr,"start read_sld_env finish\n");
}

/*-----------------------------------------------------------------------------
 * read all the objects
 * fp : input SLD file stream
 */
static void read_objects(FILE* fp)
{
  int i = 0;
  while (read_int(fp) != -1 && i++ < 100) {  /* texture : -1 -> end */
    // fprintf(stderr,"start read_object satrt\n");
    /* form */
    read_int(fp);
    /* refltype */
    read_int(fp);
    /* isrot_p*/
    int is_rot = read_int(fp);
    /* abc */
    read_vec3(fp);
    /* xyz */
    read_vec3(fp);
    /* is_invert */
    read_float(fp);
    /* refl_param */
    read_float(fp); read_float(fp);
    /* color */
    read_vec3(fp);
    /* rot */
    if(is_rot){
      read_vec3(fp);
    }
  }
}

/*-----------------------------------------------------------------------------
 * read the AND-network
 * fp : input SLD file stream
 */
static void read_and_network(FILE* fp)
{
  while(read_int(fp) != -1){
    while(read_int(fp) != -1);
  }
}

/*-----------------------------------------------------------------------------
 * read the OR-network
 * fp : input SLD file stream
 */
static void read_or_network(FILE* fp)
{
  while(read_int(fp) != -1){
    while(read_int(fp) != -1);
  }
}

/*-----------------------------------------------------------------------------
 * read the SLD file
 * fp : input SLD file stream
 */
static void read_sld(FILE* fp, int conv_to_big_endian)
{
  // fprintf(stderr,"start read_sld_env\n");
  read_sld_env(fp);
  // fprintf(stderr,"start read_sld_objects\n");
  read_objects(fp);
  // fprintf(stderr,"start read_and_network\n");
  read_and_network(fp);
  // fprintf(stderr,"start read_or_network\n");
  read_or_network(fp);
  if(conv_to_big_endian || 1){
    unsigned u;
    for(u = 0; u < sld_n_words; u++){
      int i = sld_words[u].i;
      sld_words[u].i =
        ((i & 0xff) << 24) | ((i & 0xff00) << 8) |
          ((i >> 8) & 0xff00) | ((i >> 24) & 0xff);
    }
  }
}

/*****************************************************************************
 * Each step of the server
 *****************************************************************************/

/*-----------------------------------------------------------------------------
 * read the SLD file and convert into a binary format.
 * sld_file_name : name of the SLD data file
 */

void load_sld_file(const char* sld_file_name, int conv_to_big_endian)
{
  FILE* fp = sld_file_name ? fopen(sld_file_name, "r") : stdin;
  if(fp == NULL) {
    fprintf(stderr,"cannot open SLD file %s\n", sld_file_name);
    return;
  }
  // fprintf(stderr,"file:%s is sld file\n",sld_file_name);
  read_sld(fp, conv_to_big_endian);
  fclose(fp);
}
