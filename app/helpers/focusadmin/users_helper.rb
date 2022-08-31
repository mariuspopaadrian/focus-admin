module Focusadmin
  module UsersHelper

    def article_count(user)
      published = Article.where(user_id: user.id).where(status: "published").count
      reviewing = Article.where(user_id: user.id).where(status: "reviewing").count
      draft = Article.where(user_id: user.id).where(status: "draft").count
      return published.to_s + " | " + reviewing.to_s + " | " + draft.to_s
    end

    def gender_text(id)
      if id == "1"
        "女性"
      elsif id == "2"
        "男性"
      end
    end

    def age_group_text(age_group)
      case age_group
      when "teens"
        "19歳以下"
      when "twenties"
        "20代"
      when "thirties"
        "30代"
      when "fourties"
        "40代"
      when "fifties"
        "50代"
      when "sixties_plus"
        "60歳以上"
      else
        "その他"
      end
    end

    def residential_area_text(residential_area)
      case residential_area
      when "hokkaido_tohoku"
        "北海道、東北"
      when "kanto"
        "関東"
      when "chubu"
        "中部"
      when "kinki"
        "近畿"
      when "chugoku_shikoku"
        "中国、四国"
      when "kyushu_okinawa"
        "九州、沖縄"
      when "overseas"
        "海外"
      else
        "その他"
      end
    end

  end
end
