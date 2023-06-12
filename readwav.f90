! The current implementation is compatible only with 2 channel, 16 bit audio. It can be modified to work with other
! configurations. 
 

module readwav
    implicit none

    private :: readnbytes
    public :: openwav, getfs, getnchannels, getbitspersample, readwavdata, audioread
    
contains
    
    ! Reads n bytes from the file
    ! Input:
    !   - fileunit -> the unit number of the wav file
    !   - nbytes -> the number of bytes to read
    !   - startpos -> stating possition in the file
    ! Output:
    !   - bytes -> The read bytes
    function readnbytes(fileunit, nbytes, startpos) result(bytes)
        integer,intent(in) :: fileunit, nbytes, startpos
        character(nbytes) :: bytes
         
        integer :: i

        do i=1,nbytes
            read(unit=fileunit, rec=startpos+i-1) bytes(i:i)
        end do 
    end function 

    ! Opens the wav file
    ! Inputs:
    !   - filename -> The path to the wav file
    ! Output:
    !   - fileunit -> The unit number of the opened file
    function openwav(filename) result(fileunit)
        character(*),intent(in) :: filename
        integer :: fileunit

        open(newunit=fileunit, file=filename, form='unformatted', access='direct', status='old',action='read', recl=1)
    end function

    ! Read the number of channels in the file
    ! Inputs:
    !   - fileunit -> the unit number of the wav file
    ! Output:
    !   - nch -> number of channels
    function getnchannels(fileunit) result(nch)
        integer, intent(in) :: fileunit
        character(2) :: channels
        integer(kind=2) :: nch

        channels = readnbytes(fileunit, 2, 23)
        nch = transfer(channels, nch)
    end function
    
    ! Read the sampling frequency
    ! Inputs:
    !   - fileunti -> the unit number of the wav file
    ! Output:
    !   - fs -> samplnig frequency
    function getfs(fileunit) result(fs)
        integer, intent(in) :: fileunit
        integer(kind=4) :: fs
        character(4) :: fschar 
        
        ! All is big endian
        fschar = readnbytes(fileunit, 4, 25)
        fs = transfer(fschar, fs)
    end function

    ! Reads the bits per sample
    ! Inputs:
    !   - fileunti -> the unit number of the wav file
    ! Output:
    !   - bits -> bits per sample
    function getbitspersample(fileunit) result(bits)
        integer, intent(in) :: fileunit
        integer(kind=2) :: bits

        character(2) :: bchar

        bchar = readnbytes(fileunit, 2, 35)
        bits = transfer(bchar, bits)
    end function

    ! Reads the samples in the file
    ! Inputs:
    !   - fileunti -> the unit number of the wav file
    ! Output:
    !   - samples -> the samples, as 2 byte integers
    function readwavdata(fileunit) result (samples) 
        ! Function input/output
        integer, intent(in) :: fileunit
        integer(kind=2),allocatable :: samples(:,:) ! Currently only supports 16bit samples

        ! Character variable for data samples
        character(:), allocatable :: datachar

        ! Variables for the data chunk size
        character(4) :: dschar
        integer(kind=4) :: datasize

        ! Function variables
        integer :: i
        integer(kind=2) :: moldint  ! not pretty?
        
        ! Get size of the data section (in bytes)
        dschar = readnbytes(fileunit, 4, 41)
        datasize = transfer(dschar, datasize)

        ! Allocate memory for char data
        !allocate(character(datasize) :: datachar)
    
        ! Read samples
        datachar = readnbytes(fileunit, datasize, 45)
        
        ! Allocate array for Right/Left samples
        ! We divide by 4 the total bytes because we have 2 channels (with half the samples each) and 2 bytes per sample, so we
        ! will have a total of datasize/4 integers
        allocate(samples(datasize/4, 2))

        ! The i right channel sample corresponds with the 1 and 2, 5 and 6, 9 and 10... 4i-3 and 4i-2 bytes
        ! IDEM with the left channel but with the indexes 4i-1 and 4i
        do i=1,datasize/4
            samples(i,1) = transfer(datachar(4*i-3:4*i-2), moldint)
            samples(i,2) = transfer(datachar(4*i-1:4*i), moldint)
        end do 

    end function


    function audioread(fileunit) result (samples)
        integer, intent(in) :: fileunit
        real,allocatable :: samples(:,:)
        integer(kind=2) :: intmold
    
        samples = readwavdata(fileunit)
        samples = samples/real(huge(intmold))

    end function
end module
