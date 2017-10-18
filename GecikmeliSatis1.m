clc;
clear;
benzetim=input('\nBenzetim zamanýný girin :');
benzetim_zamani=zeros(benzetim+1,1);
baslangic_stok=zeros(benzetim+1,1);
baslangic_stok_pozisyon=zeros(benzetim+1,1);
talep=zeros(benzetim+1,1);
elde_kalan=zeros(benzetim+1,1);
gecikmeli_karsilanan=zeros(benzetim+1,1);
bitis_stok_pozisyon=zeros(benzetim+1,1);
acilan_siparis=zeros(benzetim+1,1);
tedarik_suresi=zeros(benzetim+1,1);
elde_bulundurma_maliyeti=zeros(benzetim+1,1);
siparis_maliyeti=zeros(benzetim+1,1);
gecikmeli_karsilama_maliyeti=zeros(benzetim+1,1);
toplam_maliyet=zeros(benzetim+1,1);
tedarik=0;
toplam=0;
elde_bulundurma=0;
gecikmeli_maliyet=0;
siparis=0;
for i=1:benzetim
    benzetim_zamani(i,1)=i;
    rs=rand();%talep deðeri
    if (rs<=0.1599)
        talep(i,1)=1;
    elseif(rs>=0.1600 && rs<=0.4099);
        talep(i,1)=2;
    elseif(rs>=0.4100 && rs<=0.7099);
        talep(i,1)=3;
    elseif(rs>=0.71 && rs<=0.9099)
        talep(i,1)=4;
    else
        talep(i,1)=5;
    end
    if (i==1)%baþlangýç stok
        baslangic_stok(1,1)=5;
        baslangic_stok_pozisyon(1,1)=5;
        elde_kalan(1,1)=baslangic_stok(1,1)-talep(1,1);
    else
        kosul=baslangic_stok(i-1,1)-talep(i-1,1)-gecikmeli_karsilanan(i-1,1);
        if (kosul>0)
            baslangic_stok(i,1)=kosul;
        elseif(kosul<=0)
            baslangic_stok(i,1)=baslangic_stok(i,1)+0;
        end
        baslangic_stok_pozisyon(i,1)=bitis_stok_pozisyon(i-1,1)+acilan_siparis(i-1,1);
    end
    if (baslangic_stok(i,1)-talep(i,1)>0 && i~=1)
        gecikmeli_karsilanan(i,1)=0;
        if (baslangic_stok(i,1)-talep(i,1)-gecikmeli_karsilanan(i-1,1)>0)
            elde_kalan(i,1)=baslangic_stok(i,1)-talep(i,1)-gecikmeli_karsilanan(i-1,1);
            baslangic_stok(i+1,1)=elde_kalan(i,1);
        elseif(baslangic_stok(i,1)-talep(i,1)-gecikmeli_karsilanan(i-1,1)<0)
            elde_kalan(i,1)=0;
            gecikmeli_karsilanan(i,1)=abs(baslangic_stok(i,1)-talep(i,1)-gecikmeli_karsilanan(i-1,1));
            baslangic_stok(i+1,1)=0;
        end
    elseif (baslangic_stok(i,1)-talep(i,1)<=0 && i~=1)
        gecikmeli_karsilanan(i,1)=abs(baslangic_stok(i,1)-talep(i,1))+gecikmeli_karsilanan(i-1,1);
        elde_kalan(i,1)=0;
    end
    bitis_stok_pozisyon(i,1)=baslangic_stok_pozisyon(i,1)-talep(i,1);
    if (bitis_stok_pozisyon(i,1)<=3)%%acilan sipariþ
        acilan_siparis(i,1)=5;
        siparis_maliyeti(i,1)=50;
    else
        acilan_siparis(i,1)=0;
        siparis_maliyeti(i,1)=50;
    end
    rs=rand();
    if (rs<=0.2099)%tedarik süresi
        tedarik_suresi(i,1)=1;
        tedarik=1+benzetim_zamani(i,1);
    elseif(rs>=0.2100 && rs<=0.5099);
        tedarik_suresi(i,1)=2;
        tedarik=2+benzetim_zamani(i,1);
    elseif(rs>=0.5100 && rs<=0.7099);
        tedarik_suresi(i,1)=3;
        tedarik=3+benzetim_zamani(i,1);
    elseif(rs>=0.71 && rs<=0.9099)
        tedarik_suresi(i,1)=4;
        tedarik=4+benzetim_zamani(i,1);
    else
        tedarik_suresi(i,1)=5;
        tedarik=5+benzetim_zamani(i,1);
    end
    if (tedarik+1~=0 && tedarik+1<=benzetim)
        baslangic_stok(tedarik+1,1)=baslangic_stok(tedarik+1,1)+5;
        tedarik=0;
    end
    if (acilan_siparis(i,1)~=5)
        %tedarik_suresi(i,1)=0;
        siparis_maliyeti(i,1)=0;
    end
    elde_bulundurma_maliyeti(i,1)=elde_kalan(i,1)*4;
    gecikmeli_karsilama_maliyeti(i,1)=gecikmeli_karsilanan(i,1)*20;
    toplam_maliyet(i,1)=elde_bulundurma_maliyeti(i,1)+gecikmeli_karsilama_maliyeti(i,1)+siparis_maliyeti(i,1);
    toplam=toplam+toplam_maliyet(i,1);
    elde_bulundurma=elde_bulundurma+elde_bulundurma_maliyeti(i,1);
    gecikmeli_maliyet=gecikmeli_maliyet+gecikmeli_karsilama_maliyeti(i,1);
    siparis=siparis+siparis_maliyeti(i,1);
end
tablo=dataset(benzetim_zamani,baslangic_stok,baslangic_stok_pozisyon,talep,elde_kalan,gecikmeli_karsilanan,bitis_stok_pozisyon,acilan_siparis,tedarik_suresi,elde_bulundurma_maliyeti,siparis_maliyeti,gecikmeli_karsilama_maliyeti,toplam_maliyet);
fprintf('\nToplam Elde Bulundurma Maliyeti : %g',elde_bulundurma);
fprintf('\nToplam Gecikmeli Karþýlama Maliyeti : %g',gecikmeli_maliyet);
fprintf('\nToplam Sipariþ Maliyeti : %g\n',siparis);
fprintf('\n**********************************');
fprintf('\n\nToplam Maliyet : %g\n',toplam);