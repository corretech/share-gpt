Category.create(
        name:"studing_english",
        japanese_name:"英語学習",
    )
Category.create(
    japanese_name:"プログラミング",
    name:"programming",
)

Category.create(
    japanese_name:"就活",
    name:"job-hunting",
)
categories = [{
        name:"japanese_to_english",
        japanese_name:"英訳",
        parent_category: Category.find_by(name:"studing_english"),
    },{
    #    name:"english_to_japanese",
    #    japanese_name:"和訳",
    #    parent_category: Category.find_by(name:"studing_english"),
    #},{
        japanese_name:"JavaScript",
        name:"javascript",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"Python",
        name:"python",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"Ruby",
        name:"ruby",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"Java",
        name:"java",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"C言語",
        name:"C",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"C#",
        name:"C#",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"C++",
        name:"C++",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"C++",
        name:"C++",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"Kotlin",
        name:"kotlin",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"Swift",
        name:"Swift",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"HTML",
        name:"html",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"CSS",
        name:"css",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"PHP",
        name:"php",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"Scala",
        name:"scala",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"TypesSript",
        name:"Typescript",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"Go",
        name:"go",
        parent_category: Category.find_by(name:"programming"),
    },{
        japanese_name:"Perl",
        name:"perl",
        parent_category: Category.find_by(name:"programming"),
    }
]

categories.each do |c|
    category = Category.create(
        name:c[:name],
        japanese_name:c[:japanese_name],
        parent_category:c[:parent_category]
    )
end