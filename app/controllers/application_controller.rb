class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    $TweetOnaySurecindeMi=false
    $tehdit = 0
    $kufur = 0
    $aldatma = 0
    $siddet = 0

    def sadeceAnalizEt(txt)
        temizle(txt)
        txt = veritabaniStringGirisi(txt)

        str = ''
        kelimeler = txt.split(' ')
        kelimeler.each do |kelime|
            str+=",'"+kelime+"'"
        end
        str=str[1..str.length-1]

        tablo = Okelime.where("ad IN("+str+")")

        if tablo.count>0
            $tehdit = ((tablo.sum(:tehdit)/tablo.sum(:kayitsayisi))*100).to_i
            $kufur = ((tablo.sum(:kufur)/tablo.sum(:kayitsayisi))*100).to_i
            $aldatma = ((tablo.sum(:aldatma)/tablo.sum(:kayitsayisi))*100).to_i
            $siddet = ((tablo.sum(:siddet)/tablo.sum(:kayitsayisi))*100).to_i
        else
            $tehdit = 0
            $kufur = 0
            $aldatma = 0
            $siddet = 0
        end
    end
    helper_method :sadeceAnalizEt

    def dbKelimeAdEkle(kelime, t, k, a, s)

        t = (t==true)?1:0
        k = (k==true)?1:0
        a = (a==true)?1:0
        s = (s==true)?1:0

        veritabaniStringGirisi(kelime)

        if(Okelime.where(ad: kelime).count < 1)
            Okelime.create!(ad:kelime, tehdit: t, kufur: k, aldatma:a, siddet:s, kayitsayisi: 1)
        else
            kel=Okelime.where(ad: kelime).first
            kel.update_attributes!(ad:kelime, tehdit: kel.tehdit+t, kufur: kel.kufur+k, aldatma: kel.aldatma+a, siddet: kel.siddet+s, kayitsayisi: kel.kayitsayisi+1)
        end

    end
    helper_method :dbKelimeAdEkle

    def temizle(tweetText)
        tweetText.gsub!(/[^0-9A-Za-züÜşŞğĞöÖçÇıİ"' ]/, '')
        tweetText.downcase!
    end

    def veritabaniStringGirisi(str)

        kelime = ''
        str.each_char do |harf|
            if harf=="'"
                kelime+="'"+harf
            else
                kelime+=harf
            end
        end
        str = kelime

        fazlaTirnaklariKaldir(str)
    end
    helper_method :veritabaniStringGirisi

    def fazlaTirnaklariKaldir(str)

        if str.index("'''").nil?
            return str
        end

        return fazlaTirnaklariKaldir(str.gsub!("'''","''"))
    end

    def dbTweetEkle(tid, txt)

        if(Tweet.where(tweetid: tid).first.nil?)
            esikdeger = 0.7
            temizle(txt)
            txt = veritabaniStringGirisi(txt)

            sayac = 0
            sql = ''
            dbOlmayanKelimeler = Array.new
            dbTumKelimeler = Array.new
            dizi = txt.split(' ')
            dizi.each do |kelime|

                kayit = Okelime.where(ad: kelime).first
                if(kayit.nil?)
                    dbOlmayanKelimeler.push(kelime)
                else
                    sql+=",'"+kelime+"'"
                end
                dbTumKelimeler.push(kelime)
                sayac+=1

            end
            sql = sql[1..sql.length-1]

            if(sayac==dbOlmayanKelimeler.length || (dbOlmayanKelimeler.length/sayac.to_f)>esikdeger)
                Tweet.create!(user_id: current_user.id, tweetid: tid, tehdit:0, kufur:0, aldatma:0, siddet:0)
                Tweetonay.create!(tweet_id:Tweet.where(tweetid: tid).first.id, icerik:txt)
                $TweetOnaySurecindeMi = true
            else
                $TweetOnaySurecindeMi = false

                tablo = Okelime.where("ad IN("+sql+")")

                if(tablo.count>0)
                    $tehdit = tablo.sum(:tehdit)/tablo.sum(:kayitsayisi).to_f
                    $kufur = tablo.sum(:kufur)/tablo.sum(:kayitsayisi).to_f
                    $aldatma = tablo.sum(:aldatma)/tablo.sum(:kayitsayisi).to_f
                    $siddet = tablo.sum(:siddet)/tablo.sum(:kayitsayisi).to_f

                    dbTumKelimeler.each do |kelime|
                        dbKelimeAdEkle(kelime, ($tehdit>=0.5?true:false), ($kufur>=0.5?true:false), ($aldatma>=0.5?true:false), ($siddet>=0.5?true:false))
                    end

                    $tehdit = ($tehdit*100).to_i
                    $kufur = ($kufur*100).to_i
                    $aldatma = ($aldatma*100).to_i
                    $siddet = ($siddet*100).to_i

                    Tweet.create!(tweetid: tid, user_id:current_user.id, tehdit: $tehdit, kufur: $kufur, aldatma: $aldatma, siddet: $siddet)
                end
            end

        else

            t = Tweet.where(tweetid: tid).first

            if(Tweetonay.where(tweet: t.id).first.nil?)
                $TweetOnaySurecindeMi=false
                $tehdit = t.tehdit
                $kufur = t.kufur
                $aldatma = t.aldatma
                $siddet = t.siddet
            else
                $TweetOnaySurecindeMi=true
            end

        end

    end
    helper_method :dbTweetEkle

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
end
