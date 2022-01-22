# coding: utf-8

require 'active_record'
require '../../mysql_cn/db_connect.rb'

class Product < ActiveRecord::Base
end

Product.create(id: 1,
            title: 'りんご',
            description: '別名「雪の下」とよばれる国光です。',
            image_url: '/images/kokkou.jpg',
            price: 300,
            date_available: '2009-02-01 09:15:00'
);

Product.create(id: 2,
    title: 'マンゴー',
    description: '宮崎県名産「太陽のたまご」です。',
    image_url: '/images/mango.jpg',
    price: 2000,
    date_available: '2009-03-20 00:00:00'
);



