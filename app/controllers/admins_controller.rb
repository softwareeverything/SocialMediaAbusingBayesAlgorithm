class AdminsController < ApplicationController
    before_action:LoginKontrol

    def LoginKontrol
        redirect_to root_path, notice: 'Yetkisiz Erişim' if !current_user || Yonetici.find_by(user:current_user).nil?
    end

    def index
    end

    def tweetKontrol
        @tweets = Tweetonay.all
    end

    def kaydet
        unless params[:tweetid].nil? || params[:tehdit].nil? || params[:kufur].nil? || params[:aldatma].nil? || params[:siddet].nil?

            id = params[:tweetid].to_i
            t = params[:tehdit].to_i==1?1:0
            k = params[:kufur].to_i==1?1:0
            a = params[:aldatma].to_i==1?1:0
            s = params[:siddet].to_i==1?1:0

            tweet = Tweet.where(id: id).first
            unless(tweet.nil?)
                tweetText = Tweetonay.where(tweet: tweet.id).first.icerik
                temizle(tweetText)
                tweetTextDizi = tweetText.split(' ')

                str = ''
                tweetTextDizi.each do |kelime|
                    dbKelimeAdEkle(kelime, (t==1?true:false), (k==1?true:false), (a==1?true:false), (s==1?true:false))
                    str+= ",'"+kelime+"'"
                end
                str = str[1..str.length-1]

                tablo = Okelime.where("ad IN("+str+")")

                if(tablo.count>0)
                    t = tablo.sum(:tehdit)/tablo.sum(:kayitsayisi)
                    k = tablo.sum(:kufur)/tablo.sum(:kayitsayisi)
                    a = tablo.sum(:aldatma)/tablo.sum(:kayitsayisi)
                    s = tablo.sum(:siddet)/tablo.sum(:kayitsayisi)

                    Tweetonay.where(tweet_id: tweet.id).first.destroy
                    tweet.update_attributes!(tehdit: t.to_i, kufur: k.to_i, aldatma: a.to_i, siddet: s.to_i)
                end

                render 'admins/tweetKontrol'

            else
                render 'admins/tweetKontrol'

            end
        else
            render 'admins/tweetKontrol'
        end
    end
end