program sonido
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
    print "(F10.7)", samples(size(samples,1)-100:size(samples,1),1)

    close(wavunit)
end program 
