class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception


    # @param [string] tweetText
    def kelimeler tweetText, user

        temizle tweetText

        tweetTextDizi = tweetText.split(' ')

        sayac=0
        olmayankelimeler = Array.new
        sql = ''
        tweetTextDizi.each do |kelime|
            veritabaniStringGirisi(kelime)

            if Kelimead.where(:ad=>kelime).count<1
                olmayankelimeler.push kelime
            else
                sql += ',\''+kelime+'\''
            end

            sayac+=1
        end

        @tehdit = 0
        @kufur = 0
        @aldatma = 0
        @siddet = 0

        if sayac>0
            if olmayankelimeler.length==sayac or (olmayankelimeler.length.to_f/sayac) < 0.3
                txt = veritabaniStringGirisi(tweetText)
                if Tweetonay.where('tweet LIKE?',txt).count<1
                    Tweetonay.create(user_id:user.id, tweet:txt)
                end
            else
                sql = sql[1..(sql.length-1)]

                if sql.length>0
                    tablo = Kelimead.joins('INNER JOIN kelimes k ON k.kelimead_id=kelimeads.id INNER JOIN kelimeturs kt ON kt.kelime_id=k.id INNER JOIN turs t ON t.id=kt.tur_id').where("kelimeads.ad IN("+@sql+")")

                    if tablo.count>0
                        @tehdit = @tablo.where('t.tehdit=true').count/@tablo.count.to_f
                        @kufur = @tablo.where('t.kufur=true').count/@tablo.count.to_f
                        @aldatma = @tablo.where('t.aldatma=true').count/@tablo.count.to_f
                        @siddet = @tablo.where('t.siddet=true').count/@tablo.count.to_f
                    end

                    if olmayankelimeler.length>0
                        t = @tehdit>=0.5?true:false
                        k = @kufur>=0.5?true:false
                        a = @aldatma>=0.5?true:false
                        s = @siddet>=0.5?true:false

                        id = Tur.where(tehdit:t,kufur:k,aldatma:a,siddet:s).first.id

                        raise :test
                        :begin
                        olmayankelimeler.each do |kelime|
                            Kelimead.create(ad:kelime)
                            Kelime.create(kelimead_id:Kelimead.where(ad:kelime).first.id)
                            Kelimetur.create(kelime_id:Kelime.where(kelimead_id:Kelimead.where(ad:kelime).first.id).first.id, tur_id:id)
                        end
                        :end
                    end
                end

            end
        end
    end

    # @param [string] sql
    def dbKayitlar sql

    end

    def temizle tweetText
        tweetText.gsub! '.',' '
        tweetText.gsub! '!',' '
        tweetText.gsub! '?',' '
        tweetText.gsub! ',',' '
        tweetText.gsub! ':',' '
        tweetText.gsub! ';',' '
        tweetText.gsub!(/[^0-9A-Za-züÜşŞğĞöÖçÇıİ"' ]/, '')
        tweetText.downcase!
    end

    # @param [string] kelime
    def tirnakEkle kelime
        str=''
        kelime.each_char do |harf|
            if harf=="'"
                str+="'"+harf
            else
                str+=harf
            end
        end
        return str
    end

    def fazlaTirnaklariKaldir str

        if str.index("'''").nil?
            return str
        end

        return fazlaTirnaklariKaldir str.gsub! "'''","''"
    end

    def veritabaniStringGirisi str
        str = tirnakEkle str
        fazlaTirnaklariKaldir str
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
end
