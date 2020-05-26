/*
 # Made by:
 # Xavier Hernandez <xavier@astro.unam.mx>
 # Sergio Mendoza <sergio@astro.unam.mx>
 # Instituto de Astronomia UNAM
 # Ciudad Universitaria
 # Ciudad de Mexico
 # Mexico
 # Thu Jan  7 22:02:00 UTC 2016
 #
 # Last Modified: Fri Nov 11 16:38:04 UTC 2005
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/* #include <omp.h> */
/* The following is included by gsl_math.h */
/* #include <math.h> */
#include <gsl/gsl_math.h>
#include <gsl/gsl_errno.h>
#include <gsl/gsl_sf_result.h>
#include <gsl/gsl_sf_elljac.h>

/* This opens the functions to be read and written */
void openfiles() ;
/* This closes the function to be written out */
void closefiles();
/* This writes out to the *datafile pointer */
void loopfillmatrix();
void loopfreq();

/* Data matrix */
// int nmax=10000;
// First entrance is time and second is number of parameters of Likelihood
// Correct the following!
//double matrixdata[10000][10];
double matrixdata[100000][10];

// 
// double windowfunction[1000][5];


//Define here the number of rows of the observational data (wc -l):
int kl=820; //radio
//int kl=18167; //optical
//int kl=4129; //optical

/* Datafile to be open */
FILE *datafilewrite;
FILE *datafileread;


int main()
{

 openfiles();

 loopfillmatrix();

 loopfreq();

 closefiles();

 return 0;
}


void loopfreq()
{
  double fq, wf, tobs ;
  int n ;
  double ti;

  ti = 2.0;

  while( ti < 400.0 )
  {

  fq = 1.0 / ti ;
  
  n = 0;

  wf = 0;

// You have to put here the number of data sets you have:
  while( n < kl+1 )
  {

  tobs = matrixdata[n][1] ;

  
  wf = wf + ( cos( 2.0 * M_PI * fq * tobs ) ); 

  n = n + 1 ; 

  }
  
  wf = fabs(wf) / (n+1) ; 

  // windowfunction[i][1] = ti*1.0;
  // windowfunction[i][2] = wf; 

 fprintf(datafilewrite,"\n%f\t%f", ti, wf );

 printf("\n%f",ti);

 ti = ti+0.05;

}

}

void loopfillmatrix()
{
  double  tobs, Lth, sigma, blah ;
  int i;

  i=0;

// You have to put here the number of rows on the observational data:
  while( i < kl+1 )
  {
    //Data should have three columns: Time, Luminosity and sigmaLuminosity:
    fscanf(datafileread, "%lf %lf %lf", &tobs, &Lth, &sigma);
    matrixdata[i][1] = tobs ;
    i = i + 1;
  }

}

/* This functions opens the "datafilewrite" and  "datafileread" */
void openfiles()
{

//Open datafilewrite:
  datafilewrite = fopen("mrk421_radio.dat", "w");

  datafileread = fopen("mrk421.csv", "r");

  if (datafilewrite == NULL )
    {
     (void)printf("The data file output.dat was not OPEN \n\r"); 
    }
  if (datafileread == NULL )
    {
     printf("The data file observationaldata.dat was not OPEN \n\r");
    }


}

void closefiles()
{

  fclose(datafilewrite);
  fclose(datafileread);

}
