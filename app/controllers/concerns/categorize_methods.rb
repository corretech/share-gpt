module CategorizeMethods
    def words
        programming_list = {}
        Category.where(parent_category: Category.find_by(name:"programming")).each do |c|
            programming_list = programming_list.merge({c.name.to_sym => [c.name]})
        end
        list = {
            japanese_to_english:["英訳","英語に","英語で"],
            programming:["コード","プログラ"],
            "job-hunting".to_sym =>["就活","就職活動","エントリーシート","ガクチカ","面接"],
        }
        list = list.merge(programming_list)
        list
    end

    def categorize(model)
        words.each{|key, value|
            value.each do |word|
                if model.question.downcase.index(word).present?
                    puts "#{word} is_present"
                    ChatCategory.create(
                        chat: model,
                        category: Category.find_by(name: key.to_s)
                    )
                end
            end
        }
    end
end