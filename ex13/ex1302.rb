# coding: utf-8

# Studentクラスを作る

class Student
    # Studentクラスのインスタンスを初期化
    def initialize(name, age)
        @name = name
        @age = age
    end

    # Studentクラスのインスタンスの文字列表現を返す
    def to_s
        "#@name, #@age"
    end
end

# StudentBookアプリケーションのインスタンスを作る
class StudentBook
    def initialize
        @students = {}
    end

    # ハッシュにStudentクラスのインスタンスを複数作成する
    def setup_students
        @students = {
        :shin => Student.new('Shin Kuboaki', 45),
        :shinichirou => Student.new('Shinichirou Ooba', 35),
        :shingo => Student.new('Shingo Katori', 30)
        }
    end

    # すべてのインスタンスの名前と年齢を表示する
    # 処理を手続にする
    def print_students
        @students.each do |key, value|
            puts "#{key} #{value.to_s}"
        end
    end

    # StudentBookが保持しているデータをリストする
    def list_all_students
        # Studentクラスのインスタンスの作成
        setup_students
        # Studentクラスのインスタンスを表示
        print_students
    end
end

# StudentBookクラスのインスタンスを作成する
student_book = StudentBook.new

# Studentクラスのインスタンスを表示
student_book.list_all_students


