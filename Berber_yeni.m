clc;
clear;
sayac=2;
t_musteri=2;%tamamlanana m��teri
musteri=1;%gelen m��teri
musteri_s=1;%servisi devam eden m��teri 
musteri_sb=0;%servisi biten m��teri
bekleme_toplam=0;%toplam bekleme s�resi
kuyruk_toplam=0;%toplam kuyrukta bekleme s�resi
tamamlanma_zamani1=zeros(25,2);
benzetim_zamani1=zeros(25,2);
benzetim_zamani=zeros(25,2);
gelen_musteri=zeros(25,1);
servisi_devam_eden_musteri=zeros(25,1);
bekleyen_musteri=zeros(25,1);
servisi_biten_musteri=zeros(25,1);
tamamlanma_zamani=zeros(25,2);
servis_bos_kalma_suresi=zeros(25,1);
kuyruk_uzunlugu=zeros(25,1);
musteri_kuyrukta_bekleme_suresi=zeros(25,1);
servisi_devam_eden_usta=zeros(25,1);
servisi_devam_eden_cirak=zeros(25,1);
tamamlama_zamani_usta=zeros(25,2);
tamamlama_zamani_cirak=zeros(25,2);
benzetim_zamani(1,1)=8;
benzetim_zamani(1,2)=0;
tamamlanma_zamani(1,1)=0;
tamamlanma_zamani(1,2)=0;
saat=8;
dakika=0;
t_saat=8;
t_dakika = 0;

while (1)
    rs = rand();%%verilen rs de�erine g�re gas bulunur
    if (rs>=0.0000 && rs<=0.2599)
        gas=5;
    elseif (rs>=0.2600 && rs<=0.5599)
        gas=10;
    elseif (rs>=0.5600 && rs<=0.8599)
        gas=15;
    elseif (rs>=0.8600 && rs<=1.0000)
        gas=20;
    end
    rs = rand();%verilen rs de�erine g�re ss bulunur
    if (rs>=0.0000 && rs<=0.2099)
        ss=15;
    elseif (rs>=0.2100 && rs<=0.5099)
        ss=20;
    elseif (rs>=0.5100 && rs<=0.8099)
        ss=25;
    elseif (rs>=0.8100 && rs<=1.0000)
        ss=30;
    end
    if ((dakika+gas)==60)
        dakika = 0;
        saat = saat +1;%%dakika ve saat hesaplamalar�
    elseif ((dakika+gas)<60)
        dakika = dakika +gas;
    elseif (dakika+gas>60)
        dakika = ((dakika+gas)-60);
        saat = saat+1;
    end
  
    
    if ((t_dakika + ss) == 60)
        t_dakika = 0;
        t_saat =saat +1;
    elseif ((t_dakika + ss)<60)%%dakika ve saat hesaplamalar�
        t_dakika = t_dakika + ss;
    elseif (t_dakika + ss>60)
        t_dakika = ((t_dakika + ss)-60);
        t_saat = t_saat + 1;
    end
    
    if(saat>10 || (saat==10 && dakika>20))
        break;%saat 10:20 ye kadar d�nd�r�yoruz d�ng�y�
    end
    if (sayac==2)
        servis_bos_kalma_suresi(2)=dakika;%servisin bo� kalma s�resi hesaplan�r
    end
    if (sayac==2)   
        tamamlanma_zamani1(sayac,1)=t_saat;
        tamamlanma_zamani1(sayac,2)=dakika+t_dakika;
    else
        tamamlanma_zamani1(sayac,1)=t_saat;%yedek bir tabloda benzetim ve tamamlanma
        tamamlanma_zamani1(sayac,2)=t_dakika;%zamanlar� tutulur
    end
    benzetim_zamani1(sayac,1)=saat;
    benzetim_zamani1(sayac,2)=dakika;
    sayac=sayac+1;
    
    
end
sayac1=2;
sayac2=2;
benzetim_zamani(sayac1,1)=benzetim_zamani1(sayac2,1);
benzetim_zamani(sayac1,2)=benzetim_zamani1(sayac2,2);
tamamlanma_zamani(sayac1,1)=tamamlanma_zamani1(t_musteri,1);%ikinci sat�r atamas� yap�l�r
tamamlanma_zamani(sayac1,2)=tamamlanma_zamani1(t_musteri,2);
servisi_biten_musteri(sayac1)=0;
servisi_devam_eden_musteri(sayac1)=musteri_s;
gelen_musteri(sayac1)=musteri;
musteri=musteri+1;
sayac1=sayac1+1;
sayac2=sayac2+1;
while (1) %tek �al��anl� tablo i�in while d�ng�s�
    dongu=1;
    if (benzetim_zamani1(sayac2,1)==tamamlanma_zamani1(t_musteri,1) && benzetim_zamani1(sayac2,2)==tamamlanma_zamani1(t_musteri,2) && sayac1>2)
        benzetim_zamani(sayac1,1)=tamamlanma_zamani1(t_musteri,1);
        benzetim_zamani(sayac1,2)=tamamlanma_zamani1(t_musteri,2);
        t_musteri=t_musteri+1;
        tamamlanma_zamani(sayac1,1)=tamamlanma_zamani1(t_musteri,1);
        tamamlanma_zamani(sayac1,2)=tamamlanma_zamani1(t_musteri,2);
        musteri_s=musteri_s+1;%servisi devam eden m��teri
        musteri_sb=musteri_sb+1;%servisi biten m��teri
        servisi_biten_musteri(sayac1)=musteri_sb;
        servisi_devam_eden_musteri(sayac1)=musteri_s;
       if (servisi_devam_eden_musteri(sayac1)~= servisi_devam_eden_musteri(sayac1-1))
            if (benzetim_zamani(sayac1,1)==benzetim_zamani1(musteri_s+1,1))
                musteri_kuyrukta_bekleme_suresi(sayac1)=abs(benzetim_zamani(sayac1,2)-benzetim_zamani1(musteri_s+1,2));
                bekleme_toplam=bekleme_toplam+musteri_kuyrukta_bekleme_suresi(sayac1);
            else
                musteri_kuyrukta_bekleme_suresi(sayac1)=abs(60-benzetim_zamani1(musteri_s+1,2)+benzetim_zamani(sayac1,2));
                bekleme_toplam=bekleme_toplam+musteri_kuyrukta_bekleme_suresi(sayac1);
            end
        end
        gelen_musteri(sayac1)=musteri;
        musteri=musteri+1;
        sayac1=sayac1+1;
        sayac2=sayac2+1;
    elseif (benzetim_zamani1(sayac2,1)>tamamlanma_zamani1(t_musteri,1) && sayac1>2)
        benzetim_zamani(sayac1,1)=tamamlanma_zamani1(t_musteri,1);
        benzetim_zamani(sayac1,2)=tamamlanma_zamani1(t_musteri,2);
        t_musteri=t_musteri+1;
        tamamlanma_zamani(sayac1,1)=tamamlanma_zamani1(t_musteri,1);
        tamamlanma_zamani(sayac1,2)=tamamlanma_zamani1(t_musteri,2);
        musteri_s=musteri_s+1;
        musteri_sb=musteri_sb+1;%servisi biten m��teri
        servisi_biten_musteri(sayac1)=musteri_sb;
        servisi_devam_eden_musteri(sayac1)=musteri_s;
        if (kuyruk_uzunlugu(sayac1-1)==0)
            tamamlanma_zamani(sayac1,1)=0;
            tamamlanma_zamani(sayac1,2)=0;
            servisi_devam_eden_musteri(sayac1)=0;
        end
        if (servisi_devam_eden_musteri(sayac1)~= servisi_devam_eden_musteri(sayac1-1))
            if (benzetim_zamani(sayac1,1)==benzetim_zamani1(musteri_s+1,1))
                musteri_kuyrukta_bekleme_suresi(sayac1)=abs(benzetim_zamani(sayac1,2)-benzetim_zamani1(musteri_s+1,2));
                bekleme_toplam=bekleme_toplam+musteri_kuyrukta_bekleme_suresi(sayac1);
            else
                musteri_kuyrukta_bekleme_suresi(sayac1)=abs(60-benzetim_zamani1(musteri_s+1,2)+benzetim_zamani(sayac1,2));
                bekleme_toplam=bekleme_toplam+musteri_kuyrukta_bekleme_suresi(sayac1);
            end
        end
        gelen_musteri(sayac1)=0;
        sayac1=sayac1+1;
        benzetim_zamani(sayac1,1)=benzetim_zamani1(sayac2,1);
        benzetim_zamani(sayac1,2)=benzetim_zamani1(sayac2,2);
        tamamlanma_zamani(sayac1,1)=tamamlanma_zamani1(t_musteri,1);
        tamamlanma_zamani(sayac1,2)=tamamlanma_zamani1(t_musteri,2);
        servisi_devam_eden_musteri(sayac1)=musteri_s;
        gelen_musteri(sayac1)=musteri;
        musteri=musteri+1;
        sayac2=sayac2+1;
        sayac1=sayac1+1;
    elseif (benzetim_zamani1(sayac2,1)==tamamlanma_zamani1(t_musteri,1) && benzetim_zamani1(sayac2,2)>tamamlanma_zamani1(t_musteri,2) && sayac1>2)
        benzetim_zamani(sayac1,1)=tamamlanma_zamani1(t_musteri,1);
        benzetim_zamani(sayac1,2)=tamamlanma_zamani1(t_musteri,2);
        t_musteri=t_musteri+1;
        tamamlanma_zamani(sayac1,1)=tamamlanma_zamani1(t_musteri,1);
        tamamlanma_zamani(sayac1,2)=tamamlanma_zamani1(t_musteri,2);
        musteri_s=musteri_s+1;%servisi devam eden m��teri
        musteri_sb=musteri_sb+1;%servisi biten m��teri
        servisi_biten_musteri(sayac1)=musteri_sb;
        servisi_devam_eden_musteri(sayac1)=musteri_s;
        if (kuyruk_uzunlugu(sayac1-1)==0)
            tamamlanma_zamani(sayac1,1)=0;
            tamamlanma_zamani(sayac1,2)=0;
            servisi_devam_eden_musteri(sayac1)=0;
        end
         if (servisi_devam_eden_musteri(sayac1)~= servisi_devam_eden_musteri(sayac1-1))
            if (benzetim_zamani(sayac1,1)==benzetim_zamani1(musteri_s+1,1))
                musteri_kuyrukta_bekleme_suresi(sayac1)=abs(benzetim_zamani(sayac1,2)-benzetim_zamani1(musteri_s+1,2));
                bekleme_toplam=bekleme_toplam+musteri_kuyrukta_bekleme_suresi(sayac1);
            else
                musteri_kuyrukta_bekleme_suresi(sayac1)=abs(60-benzetim_zamani1(musteri_s+1,2)+benzetim_zamani(sayac1,2));
                bekleme_toplam=bekleme_toplam+musteri_kuyrukta_bekleme_suresi(sayac1);
            end
        end
        gelen_musteri(sayac1)=0;
        sayac1=sayac1+1;
        benzetim_zamani(sayac1,1)=benzetim_zamani1(sayac2,1);
        benzetim_zamani(sayac1,2)=benzetim_zamani1(sayac2,2);
        tamamlanma_zamani(sayac1,1)=tamamlanma_zamani1(t_musteri,1);
        tamamlanma_zamani(sayac1,2)=tamamlanma_zamani1(t_musteri,2);
        gelen_musteri(sayac1)=musteri;
        servisi_devam_eden_musteri(sayac1)=musteri_s;
        musteri=musteri+1;
        sayac2=sayac2+1;
        sayac1=sayac1+1;
    else
        benzetim_zamani(sayac1,1)=benzetim_zamani1(sayac2,1);
        benzetim_zamani(sayac1,2)=benzetim_zamani1(sayac2,2);
        tamamlanma_zamani(sayac1,1)=tamamlanma_zamani1(t_musteri,1);
        tamamlanma_zamani(sayac1,2)=tamamlanma_zamani1(t_musteri,2);
        servisi_biten_musteri(sayac1)=0;
        servisi_devam_eden_musteri(sayac1)=musteri_s;
        gelen_musteri(sayac1)=musteri;
        musteri=musteri+1;
        sayac1=sayac1+1;
        sayac2=sayac2+1;
    end  
    if (benzetim_zamani(sayac1-1,1)==benzetim_zamani1(sayac-1,1) && benzetim_zamani(sayac1-1,2)==benzetim_zamani1(sayac-1,2))
        break;%e�er saat 10:20 den b�y�k veya e�itse tabloya eklemeyi bitirir ve while dan ��kar
    end
    for i=(servisi_devam_eden_musteri(sayac1-1))+1:gelen_musteri(sayac1-1)
        bekleyen_musteri(sayac1-1,dongu)=i;
        dongu=dongu+1;%%kuyruk uzunlu�u ve bekleyen m��teri hesab� 
        kuyruk_uzunlugu(sayac1-1)=dongu-1;
        kuyruk_toplam=kuyruk_toplam+kuyruk_uzunlugu(sayac1-1);
    end
    if (servisi_devam_eden_musteri(sayac1-2)==0)
        if(benzetim_zamani(sayac1-1,1)==benzetim_zamani(sayac1-2,1))
            servis_bos_kalma_suresi(sayac1-1)=benzetim_zamani(sayac1-1,2)-benzetim_zamani(sayac1-2,2);
        elseif (benzetim_zamani(sayac1-1,1)>benzetim_zamani(sayac1-2,1))
            servis_bos_kalma_suresi(sayac1-1)=60-benzetim_zamani1(sayac1-2,2)+benzetim_zamani1(sayac1-2,2);
        end
    end
end

 Tek = dataset(benzetim_zamani,gelen_musteri,servisi_devam_eden_musteri,bekleyen_musteri,servisi_biten_musteri,tamamlanma_zamani,servis_bos_kalma_suresi,kuyruk_uzunlugu,musteri_kuyrukta_bekleme_suresi);
 disp(Tek);
 
 if (tamamlanma_zamani(sayac1-1,1)==10 && tamamlanma_zamani(sayac1-1,2)>20)
    toplam_musteri_sayisi=servisi_devam_eden_musteri(sayac1-1)-1;
 else
     toplam_musteri_sayisi=servisi_devam_eden_musteri(sayac1-1);
 end
 x=input('Tra� �cretini giriniz   :');
 fprintf('\t\t\t Tek �al��an\n');
 fprintf('Tek �al��anl� Toplam m��teri say�s� = %d\n',toplam_musteri_sayisi);
 ortalama_bekleme_suresi=bekleme_toplam/toplam_musteri_sayisi;
 fprintf('Ortalama bekleme s�resi = %g\n',ortalama_bekleme_suresi);
 
 ortalama_kuyruk_uzunlugu=kuyruk_toplam/(sayac1-1);

 fprintf('Ortalama kuyruk uzunlu�u = %g\n',ortalama_kuyruk_uzunlugu);
 toplam_tras_ucreti=x*toplam_musteri_sayisi;
 fprintf('Toplam Has�lat    :%d TL',toplam_tras_ucreti);
 fprintf('\t\t\t �ki �al��an\n');
 
 toplam_musteri_sayisi1=toplam_musteri_sayisi+5;
 fprintf('�ki �al��anl� Toplam m��teri say�s� = %d\n',toplam_musteri_sayisi1);
 
 ortalama_bekleme_suresi=bekleme_toplam/toplam_musteri_sayisi1;
 fprintf('Ortalama bekleme s�resi = %g\n',ortalama_bekleme_suresi);
 
 ortalama_kuyruk_uzunlugu=(kuyruk_toplam-5)/(sayac1-1);
 fprintf('Ortalama kuyruk uzunlu�u = %g\n',ortalama_kuyruk_uzunlugu);
 
 toplam_tras_ucreti=x*toplam_musteri_sayisi1;
 fprintf('Toplam Has�lat    :%d TL',toplam_tras_ucreti);
 
 
 
 