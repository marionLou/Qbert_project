/*******************************************************************************
* MyMDDFS - Memory Disk Drive File System                                      *
********************************************************************************
* Description:                                                                 *
* Demo from Microhip to illustrate the use of MDDFS                            *
********************************************************************************
* Version 1.00 - Sept 2011                                                     *
* Version 2.00 - August 2014                                                   *
*
* Brought with version 2.00:
*   - An algorithm extracting data from a BMP file on the SD card and sending
*     color bytes to the FPGA on the DE0-Nano board.
*     The base principle of the algorithm is inspired from raster24.c, written
*     by B. Green in 2002 and available here (accessed August 2, 2014):
*     http://dasl.mem.drexel.edu/alumni/bGreen/www.pages.drexel.edu/_weg22/colorBMP.html
*******************************************************************************/

#define  MyMDDFS

#define MAX_NUM  20
#define MULT_BUF 16


/*******************************************************************************
//NOTE : DISABLE MACRO "SUPPORT_LFN" IN "FSconfig.h" FILE TO WORK WITH THIS DEMO
         EFFECTIVELY. DISABLING "SUPPORT_LFN" WILL SAVE LOT OF MEMORY FOR THIS
         DEMO.
********************************************************************************/

#include "MyApp.h"
#include <math.h>
#include <string.h>

/******************************************************************************/

int MDDFS_IntStatus;
int MDDFS_SPICON_save;
int MDDFS_SPIBRG_save;

void MyMDDFS_SaveSPI(void)
{
    /* Disable all Interrupts */
    MDDFS_IntStatus = INTDisableInterrupts();

    /* Save SPI configuration */
    MDDFS_SPICON_save = SPICON1;
    MDDFS_SPIBRG_save = SPIBRG;

}


void MyMDDFS_RestoreSPI(void)
{
    /* set Slave Select high ((disable SPI chip select on MRF24WB0M)   */
    SD_CS = 1;

    /* Restore SPI Configuration */
    SPIENABLE = 0;
    SPIBRG = MDDFS_SPIBRG_save;
    SPICON1 = MDDFS_SPICON_save;
    SPIENABLE = 1;

    /* Restore the Interrupts */
    INTRestoreInterrupts(MDDFS_IntStatus);
}

/******************************************************************************/

void MyMDDFS_loadSlideshow(char* theCmd) {

    unsigned char tabWrite[100];
    char* end;
    int num_img;
    char base_name[15];
    char curr_img_name[21];
    int i;

    MyConsole_SendMsg("What is the number of images in the slideshow ?\n\t");
    sprintf(tabWrite, "Please enter an integer smaller or equal to %d : ", MAX_NUM);
    MyConsole_SendMsg(tabWrite);

    while(1) {
        //Waits for the user to type something.
        //Input pointer theCmd is modified.
        while (!MyConsole_GetCmd());

        //Converts to a number the string the user has just written.
        num_img = (int)strtol(theCmd, &end, 10);

        //Verifies if what the user has written is valid.
        //If not, asks for another number.
        if (*end) {
            sprintf(tabWrite, "\tConversion error, wrong format %s.\n\t", end);
            MyConsole_SendMsg(tabWrite);
            MyConsole_SendMsg("Please enter a correct number : ");
        }
        else if ((num_img <= 0) || (num_img > MAX_NUM)) {
            MyConsole_SendMsg("\t>The input number is not in the valid range.\n\t");
            MyConsole_SendMsg("Please enter a correct number : ");
        }
        else
            break;
    }

    //Sends to the FPGA the number of images that will be loaded.
    MyCyclone_Write(CYCLONE_IMGNUM, num_img);

    //Now, the same is done with the base name of the slides.
    //Again, the input pointer theCmd will be modified.
    MyConsole_SendMsg("\tNow, please enter the common base name to all the slides : ");
    while (!MyConsole_GetCmd());
    strcpy(base_name, theCmd);
    MyConsole_SendMsg("\t");

    //Loads the slideshow image per image and displays some info about the
    //current progress.
    //If anything goes wrong, the loading is stopped and the user is warned.
    for (i=0; i<num_img; i++) {
        sprintf(curr_img_name, "%s%d.bmp", base_name, i+1);
        if (MyMDDFS_ReadImg(curr_img_name)) {
            MyConsole_SendMsg("An error occurred while opening a file.\n\t");
            MyConsole_SendMsg("Verify the SD card and your inputs, then try again!\n\t");
            break;
        }
    }

    MyConsole_SendMsg("\n\r>");
    return;
}


int MyMDDFS_ReadImg (char* name)
{
   FSFILE		*bmpInput;
   int                  rows, columns;
   unsigned char	*pChar;
   long			fileSize;
   int			bitsPixel;
   int			r=1, c=0, i=0, j=0;
   unsigned char        *red_buf_data;
   unsigned char        *green_buf_data;
   unsigned char        *blue_buf_data;
   unsigned char        tabWrite[100];

   /*
    * To communicate with the SD Card in SPI, all other SPI communications
    * are halted and their status are saved; interrupts are disabled.
    *
    * As one can't send data over SPI to the FPGA when SPI is reserved for the
    * SD card, the values just read must be stored in arrays and sent
    * to the FPGA later.
    * However, the memory size of the PIC is limited and isn't sufficient to
    * store a whole BMP file.
    * The memory area allocated to store the read values is close to the maximum
    * allowed and, multiple times, SPI is restored to send data to the FPGA.
    * SPI is then saved again to reopen the BMP file and continue reading.
    *
    * Finally, all the allocated resources are freed.
    */
   MyMDDFS_SaveSPI();

   // Checks if an SD card is detected.
   // If not, restores the SPI.
   if (!MDD_MediaDetect()) {
       MyMDDFS_RestoreSPI();
       MyConsole_SendMsg(">MyMDDFS - Error MDD_MediaDetect\n>");
       return 1;
   }

   // Initializes the library.
   // If there is an error, restores the SPI.
   if (!FSInit()) {
       MyMDDFS_RestoreSPI();
       MyConsole_SendMsg(">MyMDDFS - Error FSInit\n>");
       return 1;
   }

   // Warns the user that initialization was successful.
   sprintf(tabWrite, ">MyMDDFS - Currently opening image %s.\n\t", name);
   MyConsole_SendMsg(tabWrite);

   // Opens the image file.
   // If it doesn't exist, restores the SPI.
   bmpInput = FSfopen(name, "r");
   if (bmpInput == NULL) {
       MyMDDFS_RestoreSPI();
       MyConsole_SendMsg(">MyMDDFS - Image not found\n\t");
       return 1;
   }

   // Places the cursor at the beginning of the file.
   FSfseek(bmpInput, 0L, SEEK_END);

   // Gets general information about the BMP file, as
   //   - the size of the file (should be 1152054),
   //   - the number of columns (should be 800),
   //   - the number of rows (should be 480),
   //   - the number of bits per pixel (should be 24 bits, so 3 bytes).
   // The size of the file is found as follows :
   //   - 54 bytes for the general information,
   //   - 800x480 pixels * 3 bytes = 152000 bytes for the image data.
   fileSize  =      MyMDDFS_getImageInfo(bmpInput, 2, 4);
   columns   = (int)MyMDDFS_getImageInfo(bmpInput, 18, 4);
   rows      = (int)MyMDDFS_getImageInfo(bmpInput, 22, 4);
   bitsPixel = (int)MyMDDFS_getImageInfo(bmpInput, 28, 4);

   // Prints the general information to the console, so you can check your
   // image format is correct. This algorithm is general with every image size,
   // but the controller in the FPGA will not work for image sizes different
   // from 800x480.
   // Note that for a number of columns higher than 800, the PIC32 could
   // encounter some memory problems during the dynamic allocation (see below).
   // If you ever need to acquire data from such an image, you can reduce
   // 'MULT_BUF' (on the top of this file) to save memory.
   sprintf(tabWrite, "Width: %d\n\t", columns);
   MyConsole_SendMsg(tabWrite);
   sprintf(tabWrite, "Height: %d\n\t", rows);
   MyConsole_SendMsg(tabWrite);
   sprintf(tabWrite, "File size: %ld\n\t", fileSize);
   MyConsole_SendMsg(tabWrite);
   sprintf(tabWrite, "Bits/pixel: %d\n\t", bitsPixel);
   MyConsole_SendMsg(tabWrite);

   // Allocates space to store the color values read from the SD card.
   // The size of the array will be sufficient to store data for a number
   // 'MULT_BUF' of rows.
   red_buf_data = (unsigned char*)malloc(MULT_BUF*columns*sizeof(unsigned char));
   green_buf_data = (unsigned char*)malloc(MULT_BUF*columns*sizeof(unsigned char));
   blue_buf_data = (unsigned char*)malloc(MULT_BUF*columns*sizeof(unsigned char));
   // Initializes the read pointer.
   pChar = (unsigned char*)malloc(sizeof(unsigned char));

   // Processes the image until the last row has been read.
   while (r<=rows) {

        // Just warns the user that half the process has been done.
        if (r==rows/2) {
            MyConsole_SendMsg("First half of the image is loaded.\n\t");
        }

        // Sets the cursor so as to process the rows in reverse order (please
        // refer to introductory slides).
        // r is incremented each time a row has been processed.
        FSfseek(bmpInput, fileSize - 3*columns*r, SEEK_SET);

        // Reads data for each column in the current row.
        // For each pixel, there are three bytes for color information.
        // For each of those bytes, the value is read and then stored in
        // an array, waiting to be transmitted to the FPGA when SPI will be
        // available.
        for (c=0; c<columns; c++) {

            // Reads the first byte to get the blue value of the current pixel.
            FSfread(pChar, sizeof(char), 1, bmpInput);
            blue_buf_data[c+i*columns] = *pChar;

            // Reads the second byte to get the green value of the current pixel.
            FSfread(pChar, sizeof(char), 1, bmpInput);
            green_buf_data[c+i*columns] = *pChar;

            // Reads the third byte to get the red value of the current pixel.
            FSfread(pChar, sizeof(char), 1, bmpInput);
            red_buf_data[c+i*columns] = *pChar;
        }

        // i is a small variable to keep track of the number of rows which are
        // stored in the color arrays.
        i++;

        // When i becomes equal to the maximum number of rows the array can
        // store or when the whole image has been processed, it is time to
        // restore the SPI, send data to the FPGA, then save the SPI again and
        // continue reading the image file if there is still something to read.
        if ((i==MULT_BUF) || (r==rows)) {

            // Closes the file and restores SPI.
            FSfclose(bmpInput);
            MyMDDFS_RestoreSPI();

            // Sends data to the FPGA.
            for (j=0; j<columns*i; j++) {
                MyCyclone_Write(CYCLONE_RED, red_buf_data[j]);
                MyCyclone_Write(CYCLONE_GREEN, green_buf_data[j]);
                MyCyclone_Write(CYCLONE_BLUE, blue_buf_data[j]);
            }

            i = 0;

            // If there is still something to read, open back the file.
            // There is no need to check again for an SD card and to initialize
            // the library.
            if (r != rows) {

                MyMDDFS_SaveSPI();

                // Here, in the case there is a problem in opening back the
                // file, one shall not forget to free the allocated resources.
                bmpInput = FSfopen(name, "r");
                if (bmpInput == NULL) {
                    MyMDDFS_RestoreSPI();
                    free(red_buf_data);
                    free(green_buf_data);
                    free(blue_buf_data);
                    free(pChar);
                    MyConsole_SendMsg(">MyMDDFS - Problem while reading the image\n\t>");
                    return 1;
                }
            }
        }

        // After that, a whole row of the image will have been processed.
        r++;
   }

   // The full image has now been acquired.
   // Resources must absolutely be freed, otherwise there won't be enough
   // remaining space to allocate resources when reading another file.

   sprintf(tabWrite, ">MyMDDFS - Image %s acquired.\n\t", name);
   MyConsole_SendMsg(tabWrite);

   free(red_buf_data);
   free(green_buf_data);
   free(blue_buf_data);
   free(pChar);

   return 0;
}


// Small subroutine to get some general information about the BMP file.
long MyMDDFS_getImageInfo(FSFILE* inputFile, long offset, int numberOfChars)
{
  unsigned char		*pChar;
  long			value=0L;
  int			i;

  // Initializes the read pointer.
  pChar = (unsigned char*)malloc(sizeof(unsigned char));

  FSfseek(inputFile, offset, SEEK_SET);

  for(i=1; i<=numberOfChars; i++)
  {
    FSfread(pChar, sizeof(char), 1, inputFile);

    // Computes value based on adding bytes.
    value = (long)(value + (*pChar)*(pow(256, (i-1))));
  }

  free(pChar);

  return(value);
}


/******************************************************************************/


char sendBuffer[] = "This is test string 1";
char send2[] = "2";
char receiveBuffer[50];

void MyMDDFS_Test (void)
{
   FSFILE * pointer;
   char path[30];
   char count = 30;
   char * pointer2;
   SearchRec rec;
   unsigned char attributes;
   unsigned char size = 0, i;

   MyMDDFS_SaveSPI();

   //Check if an SD card is detected
   if (!MDD_MediaDetect()) {
       MyMDDFS_RestoreSPI();
       MyConsole_SendMsg("MyMDDFS - Error MDD_MediaDetect\n>");
       return;
   }

   // Initialize the library
   if (!FSInit()) {
       MyMDDFS_RestoreSPI();
       MyConsole_SendMsg("MyMDDFS - Error FSInit\n>");
       return;
   }

#ifdef ALLOW_WRITES
   // Create a file
   pointer = FSfopen ("FILE3.TXT", "w");
   if (pointer == NULL)
      MyConsole_SendMsg("MyMDDFS - Error FSfopen\n>");

   // Write 21 1-byte objects from sendBuffer into the file
   if (FSfwrite (sendBuffer, 1, 21, pointer) != 21)
      MyConsole_SendMsg("MyMDDFS - Error FSfwrite\n>");

   // FSftell returns the file's current position
   if (FSftell (pointer) != 21)
      MyConsole_SendMsg("MyMDDFS - Error FSftell\n>");

   // FSfseek sets the position one byte before the end
   // It can also set the position of a file forward from the
   // beginning or forward from the current position
   if (FSfseek(pointer, 1, SEEK_END))
      MyConsole_SendMsg("MyMDDFS - Error FSfseek\n>");

   // Write a 2 at the end of the string
   if (FSfwrite (send2, 1, 1, pointer) != 1)
      MyConsole_SendMsg("MyMDDFS - Error FSfwrite\n>");

   // Close the file
   if (FSfclose (pointer))
      MyConsole_SendMsg("MyMDDFS - Error FSfclose\n>");

   // Create a second file
   pointer = FSfopen ("FILE1.TXT", "w");
   if (pointer == NULL)
      MyConsole_SendMsg("MyMDDFS - Error FSfopen\n>");

   // Write the string to it again
   if (FSfwrite ((void *)sendBuffer, 1, 21, pointer) != 21)
      MyConsole_SendMsg("MyMDDFS - Error FSfwrite\n>");

   // Close the file
   if (FSfclose (pointer))
      MyConsole_SendMsg("MyMDDFS - Error FSfclose\n>");
#endif

   // Open file 1 in read mode
   pointer = FSfopen ("FILE1.TXT", "r");
   if (pointer == NULL)
      MyConsole_SendMsg("MyMDDFS - Error FSfopen\n>");

   if (FSrename ("FILE2.TXT", pointer))
      MyConsole_SendMsg("MyMDDFS - Error FSfrename\n>");

   // Read one four-byte object
   if (FSfread (receiveBuffer, 4, 1, pointer) != 1)
      MyConsole_SendMsg("MyMDDFS - Error FSfread\n>");

   // Check if this is the end of the file- it shouldn't be
   if (FSfeof (pointer))
      MyConsole_SendMsg("MyMDDFS - Error FSfeof\n>");

   // Close the file
   if (FSfclose (pointer))
      MyConsole_SendMsg("MyMDDFS - Error FSfclose\n>");

   // Make sure we read correctly
   if ((receiveBuffer[0] != 'T') ||
       (receiveBuffer[1] != 'h')  ||
       (receiveBuffer[2] != 'i')  ||
       (receiveBuffer[3] != 's'))
   {
      MyConsole_SendMsg("MyMDDFS - Error receiveBuffer\n>");
   }

#ifdef ALLOW_DIRS
   // Create a small directory tree
   // Beginning the path string with a '.' will create the tree in
   // the current directory.  Beginning with a '..' would create the
   // tree in the previous directory.  Beginning with just a '\' would
   // create the tree in the root directory.  Beginning with a dir name
   // would also create the tree in the current directory
   if (FSmkdir (".\\ONE\\TWO\\THREE"))
      MyConsole_SendMsg("MyMDDFS - Error FSmkdir\n>");

   // Change to directory THREE in our new tree
   if (FSchdir ("ONE\\TWO\\THREE"))
      MyConsole_SendMsg("MyMDDFS - Error FSchdir\n>");

   // Create another tree in directory THREE
   if (FSmkdir ("FOUR\\FIVE\\SIX"))
      MyConsole_SendMsg("MyMDDFS - Error FSmkdir\n>");

   // Create a third file in directory THREE
   pointer = FSfopen ("FILE3.TXT", "w");
   if (pointer == NULL)
      MyConsole_SendMsg("MyMDDFS - Error FSfopen\n>");

   // Get the name of the current working directory
   // it should be "\ONE\TWO\THREE"
   pointer2 = FSgetcwd (path, count);
   if (pointer2 != path)
      MyConsole_SendMsg("MyMDDFS - Error FSgetcwd\n>");

   // Simple string length calculation
   i = 0;
   while(*(path + i) != 0x00)
   {
      size++;
      i++;
   }
   // Write the name to FILE3.TXT
   if (FSfwrite (path, size, 1, pointer) != 1)
      MyConsole_SendMsg("MyMDDFS - Error FSfwrite\n>");

   // Close the file
   if (FSfclose (pointer))
      MyConsole_SendMsg("MyMDDFS - Error FSfclose\n>");

   // Create some more directories
   if (FSmkdir ("FOUR\\FIVE\\SEVEN\\..\\EIGHT\\..\\..\\NINE\\TEN\\..\\ELEVEN\\..\\TWELVE"))
      MyConsole_SendMsg("MyMDDFS - Error FSmkdir\n>");

   /*******************************************************************
      Now our tree looks like this

      \ -> ONE -> TWO -> THREE -> FOUR -> FIVE -> SIX
                                                 -> SEVEN
                                                 -> EIGHT
                                            NINE -> TEN
                                                 -> ELEVEN
                                                 -> TWELVE
   ********************************************************************/

   // This will delete only directory eight
   // If we tried to delete directory FIVE with this call, the FSrmdir
   // function would return -1, since FIVE is non-empty
   if (FSrmdir ("\\ONE\\TWO\\THREE\\FOUR\\FIVE\\EIGHT", FALSE))
      MyConsole_SendMsg("MyMDDFS - Error FSrmdir\n>");

   // This will delete directory NINE and all three of its sub-directories
   if (FSrmdir ("FOUR\\NINE", TRUE))
      MyConsole_SendMsg("MyMDDFS - Error FSrmdir\n>");

   // Change directory to the root dir
   if (FSchdir ("\\"))
      MyConsole_SendMsg("MyMDDFS - Error FSchdir\n>");
#endif

#ifdef ALLOW_FILESEARCH
   // Set attributes
   attributes = ATTR_ARCHIVE | ATTR_READ_ONLY | ATTR_HIDDEN;

   // Functions "FindFirst" & "FindNext" can be used to find files
   // and directories with required attributes in the current working directory.

   // Find the first TXT file with any (or none) of those attributes that
   // has a name beginning with the letters "FILE"
   // These functions are more useful for finding out which files are
   // in your current working directory
   if (FindFirst ("FILE*.TXT", attributes, &rec))
      MyConsole_SendMsg("MyMDDFS - Error FindFirst\n>");

   // Keep finding files until we get FILE2.TXT
   while(rec.filename[4] != '2')
   {
      if (FindNext (&rec))
         MyConsole_SendMsg("MyMDDFS - Error FindNext\n>");
   }

   // Delete file 2
   // NOTE : "FSremove" function deletes specific file not directory.
   //        To delete directories use "FSrmdir" function
   if (FSremove (rec.filename))
      MyConsole_SendMsg("MyMDDFS - Error FSremove\n>");
#endif

/*********************************************************************
   The final contents of our card should look like this:
   \ -> FILE1.TXT
      -> ONE       -> TWO -> THREE -> FILE3.TXT
                                   -> FOUR      -> FIVE -> SIX
                                                        -> SEVEN

*********************************************************************/

   MyConsole_SendMsg("MyMDDFS - Test ok\n>");
   MyMDDFS_RestoreSPI();
}










