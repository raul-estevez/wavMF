program main 
    use readwav

    implicit none

    character(*),parameter :: filename = "data/guitarra.wav"
    integer :: wavunit, fs, nch, bits
    real,allocatable :: samples(:,:)
    
    real :: moldreal
    integer :: i

    wavunit = openwav(filename)

    fs = getfs(wavunit)
    nch = getnchannels(wavunit)
    bits = getbitspersample(wavunit)
    samples = audioread(wavunit)


    print *, "fs=",fs
    print *, "nch=",nch
    print *, "bps=", bits
    print "(F10.7)", samples(1:10,1) ! The first 10 samples from the right channel

    close(wavunit)
end program 
