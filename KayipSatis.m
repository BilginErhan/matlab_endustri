clc;
clear;
benzetim=input('\nBenzetim zamanýný girin :');
while (benzetim<4)
    fprintf('benzetim zamanýnýn 4 den büyük giriniz !!');
    benzetim=input('\nBenzetim zamanýný girin :');
end
benzetim_zamani=zeros(benzetim,1);
baslangic_stok=zeros(benzetim,1);
talep=zeros(benzetim,1);
elde_kalan=zeros(benzetim,1);
kayip=zeros(benzetim,1);
stok_pozisyon=zeros(benzetim,1);
acilan_siparis=zeros(benzetim,1);
tedarik_suresi=zeros(benzetim,1);
elde_bulundurma_maliyeti=zeros(benzetim,1);
kayip_satis_maliyeti=zeros(benzetim,1);
siparis_maliyeti=zeros(benzetim,1);
toplam_maliyet=zeros(benzetim,1);
q=[224 275 325 425];
r=[200 225 250 275];
tedarik=0;
endusuk_maliyet1=0;
endusuk_maliyet2=0;
endusuk_maliyet3=0;
endusuk_maliyet4=0;
endusuk_maliyet=0;
for i=1:4
    for j=1:benzetim
        benzetim_zamani(j,1)=j;
        rs=rand();%talep için rs deðerinin bulunmasý
        talep(j,1)=round(80+50*rs);        
        if (j==1)%baþlangýç stok
            baslangic_stok(1,1)=q(i);
        elseif(elde_kalan(j-1,1)>0 && benzetim_zamani(j,1)~=tedarik)
            baslangic_stok(j,1)=elde_kalan(j-1,1);
        elseif(elde_kalan(j-1,1)>0 && benzetim_zamani(j,1)==tedarik)
            baslangic_stok(j,1)=elde_kalan(j-1,1)+q(i);
        elseif(elde_kalan(j-1,1)==0 && benzetim_zamani(j,1)~=tedarik)
            baslangic_stok(j,1)=0;
        elseif(elde_kalan(j-1,1)==0 && benzetim_zamani(j,1)==tedarik)
            baslangic_stok(j,1)=q(i);
        end
        if(baslangic_stok(j,1)-talep(j,1)<0)%kayýp
            kayip(j,1)=abs(baslangic_stok(j,1)-talep(j,1));
            elde_kalan(j,1)=0;
        else%%elde kalan
            elde_kalan(j,1)=baslangic_stok(j,1)-talep(j,1);
            kayip(j,1)=0;
        end
        if (j==1)%stok pozisyonu
            stok_pozisyon(j,1)=elde_kalan(j,1);
        else
            if (stok_pozisyon(j-1,1)<=r(i))
                rs=rand();
                if (rs<0.7599)%tedarik süresi
                    tedarik_suresi(j-1,1)=2;
                elseif(rs>0.7600)
                    tedarik_suresi(j-1,1)=3;
                end
                siparis_maliyeti(j,1)=50;
                tedarik=tedarik_suresi(j-1,1)+j;
                eklendi=1;
                acilan_siparis(j-1,1)=q(i);
                if (elde_kalan(j,1)>0)
                    stok_pozisyon(j,1)=elde_kalan(j,1)+q(i);
                else
                    stok_pozisyon(j,1)=q(i)-baslangic_stok(j,1);
                end
            elseif(elde_kalan(j,1)>0)
                stok_pozisyon(j,1)=stok_pozisyon(j-1,1)-talep(j,1);
            elseif(elde_kalan(j,1)==0)
                stok_pozisyon(j,1)=stok_pozisyon(j-1,1)-baslangic_stok(j,1);
            end
        end
        elde_bulundurma_maliyeti(j,1)=elde_kalan(j,1)*0.20;
        kayip_satis_maliyeti(j,1)=kayip(j,1)*100;
        toplam_maliyet(j,1)=elde_bulundurma_maliyeti(j,1)+kayip_satis_maliyeti(j,1)+siparis_maliyeti(j,1);
        endusuk_maliyet=endusuk_maliyet+toplam_maliyet(j,1);
    end
    if (i==1)
        tablo1=dataset(benzetim_zamani,baslangic_stok,talep,elde_kalan,kayip,stok_pozisyon,acilan_siparis,tedarik_suresi,elde_bulundurma_maliyeti,kayip_satis_maliyeti,siparis_maliyeti,toplam_maliyet);
        endusuk_maliyet1=endusuk_maliyet;
    elseif(i==2)
        tablo2=dataset(benzetim_zamani,baslangic_stok,talep,elde_kalan,kayip,stok_pozisyon,acilan_siparis,tedarik_suresi,elde_bulundurma_maliyeti,kayip_satis_maliyeti,siparis_maliyeti,toplam_maliyet);
        endusuk_maliyet2=endusuk_maliyet;
    elseif(i==3)
        tablo3=dataset(benzetim_zamani,baslangic_stok,talep,elde_kalan,kayip,stok_pozisyon,acilan_siparis,tedarik_suresi,elde_bulundurma_maliyeti,kayip_satis_maliyeti,siparis_maliyeti,toplam_maliyet);
        endusuk_maliyet3=endusuk_maliyet;
    elseif(i==4)
        tablo4=dataset(benzetim_zamani,baslangic_stok,talep,elde_kalan,kayip,stok_pozisyon,acilan_siparis,tedarik_suresi,elde_bulundurma_maliyeti,kayip_satis_maliyeti,siparis_maliyeti,toplam_maliyet);
        endusuk_maliyet4=endusuk_maliyet;
    end
    benzetim_zamani=zeros(benzetim,1);
    baslangic_stok=zeros(benzetim,1);
    talep=zeros(benzetim,1);
    elde_kalan=zeros(benzetim,1);
    kayip=zeros(benzetim,1);
    stok_pozisyon=zeros(benzetim,1);
    acilan_siparis=zeros(benzetim,1);
    tedarik_suresi=zeros(benzetim,1);
    elde_bulundurma_maliyeti=zeros(benzetim,1);
    kayip_satis_maliyeti=zeros(benzetim,1);
    siparis_maliyeti=zeros(benzetim,1);
    toplam_maliyet=zeros(benzetim,1);
    endusuk_maliyet=0;
end
endusuk_maliyet=endusuk_maliyet1;
indis=1;
if (endusuk_maliyet>endusuk_maliyet2)
    endusuk_maliyet=endusuk_maliyet2;
    indis=2;
end
if(endusuk_maliyet>endusuk_maliyet3)
    endusuk_maliyet=endusuk_maliyet3;
    indis=3;
end
if(endusuk_maliyet>endusuk_maliyet4)
    endusuk_maliyet=endusuk_maliyet4;
    indis=4;
end
fprintf('\n\n Q : %d ve R : %d için',q(1),r(1));
fprintf('\n en düþük maliyet ve en uygun politika : %.3f',endusuk_maliyet1);
fprintf('\n\n Q : %d ve R : %d için',q(2),r(2));
fprintf('\n en düþük maliyet ve en uygun politika : %.3f',endusuk_maliyet2);
fprintf('\n\n Q : %d ve R : %d için',q(3),r(3));
fprintf('\n en düþük maliyet ve en uygun politika : %.3f',endusuk_maliyet3);
fprintf('\n\n Q : %d ve R : %d için',q(4),r(4));
fprintf('\n en düþük maliyet ve en uygun politika : %.3f',endusuk_maliyet4);

fprintf('\n\n ---------Sonuç olarak----------------');

fprintf('\n\n Q : %d ve R : %d için\n',q(indis),r(indis));
fprintf('\n\n en düþük maliyet ve en uygun politika : %.3f\n',endusuk_maliyet);