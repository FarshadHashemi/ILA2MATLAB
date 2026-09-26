clc
clear
close all

fs=2496e6;
adc=3;
fdomain=(-8192:8191)*fs/16384/1e6+fs/2/1e6;
tdomain=(0:16383)/fs*1e6;
w=hann(2^14);
while(1)

    iladata = importfile2('C:\p\KR47\iladata.csv');
    if size(iladata)==[2048,16]
        for k0=1:16
            for k1=0:2047
                str=reshape(char(iladata(k1+1,k0)),4,[]).';
                for k2=1:8
                    arr16k(8*k1+k2,k0)=hex2dec(str(9-k2,:));
                    if arr16k(8*k1+k2,k0)>32767
                        arr16k(8*k1+k2,k0)=arr16k(8*k1+k2,k0)-65536;
                    end
                end
            end
        end
        for k=1:8
            sig(:,k)=arr16k(:,2*k-1)+1j*arr16k(:,2*k);
            SIG(:,k)=fftshift(fft(sig(:,k).*w));
        end
        
        % plot(real(sig(1:200,3)))
        for k=1:8
            subplot(2,4,k)
            plot(fdomain,db(SIG(:,k)))
            % plot(tdomain,real(sig(:,k)))
        end

        [amp,loc]=max(db(SIG(:,1)));

        pause(1)
        fullscale=(max(abs(sig(:,adc))))
        amp=db(max(abs(SIG(:,adc))))
        noisefloor=db(median(abs(SIG(:,adc))))
        SNR=snr(real(sig(:,adc)))
        % SNR=amp-noisefloor -10*log10(2^13)
        SFDR=sfdr(real(sig(:,adc)))
        ENOB=(SNR-1.76)/6.02
        difphi=rad2deg(angle(SIG(loc,1))-angle(SIG(loc,adc)));
        if difphi>180
            difphi=difphi-360
        elseif difphi<-180
            difphi=difphi+360
        else
            difphi
        end
    end 
end


