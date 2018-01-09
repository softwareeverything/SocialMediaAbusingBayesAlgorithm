class AdminsController < ApplicationController
    before_action:LoginKontrol

    def LoginKontrol
        redirect_to root_path, notice: 'Yetkisiz Erişim' if !current_user || Yonetici.find_by(user:current_user).nil?
    end

    def index
        @tweetonay = Tweetonay.all
    end

    def deneme
        @kel = fazlaTirnaklariKaldir "'Mer'''''haba 'A''l'''i'''' '''''''''Nasılsın?'''''..'""'.' '"
    end

    def kaydet
        unless params[:field].nil? || params[:tehdit].nil? || params[:kufur].nil? || params[:aldatma].nil? || params[:siddet].nil?

            id = params[:field]
            t = params[:tehdit]
            k = params[:kufur]
            a = params[:aldatma]
            s = params[:siddet]

            turId = Tur.where(tehdit:t,kufur:k,aldatma:a,siddet:s).first.id

            tweetText = Tweetonay.find(id).tweet
            temizle tweetText

            tweetTextDizi = tweetText.split(' ')

            sql = ''
            tweetTextDizi.each do |kelime|
                sql += ',\''+(veritabaniStringGirisi kelime)+'\''
            end
            sql = sql[1..(sql.length-1)]

        else
            redirect_to 'admins/tweetKontrol', notice: 'Eksik parametre girildi!'
        end
    end
end