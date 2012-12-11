# encoding: utf-8


namespace :bootstrap do
  desc "Create the Categories"
  task :default_categories => :environment do
    Category.create( :name => 'Research and Development', :isim => 'Araştırma - Geliştirme')
    Category.create( :name => 'Information', :isim => 'Bilişim')
    Category.create( :name => 'Translation', :isim => 'Çeviri')
    Category.create( :name => 'Counseling', :isim => 'Danışmanlık')
    Category.create( :name => 'International Trade', :isim => 'Dış Ticaret')
    Category.create( :name => 'Editorial', :isim => 'Editörlük - Yazı İşleri')
    Category.create( :name => 'Education', :isim => 'Eğitim - Öğretim')
    Category.create( :name => 'Finance - Banking', :isim => 'Finans - Banka')
    Category.create( :name => 'Real estate', :isim => 'Gayrimenkul')
    Category.create( :name => 'Security', :isim => 'Güvenlik - Koruma')
    Category.create( :name => 'Legal Services', :isim => 'Hukuk')
    Category.create( :name => 'Administrative', :isim => 'İdari')
    Category.create( :name => 'Pharmaceutical - Biotechnology', :isim => 'İlaç - Biyoteknoloji')
    Category.create( :name => 'Human Resources', :isim => 'İnsan Kaynakları')
    Category.create( :name => 'Logistics', :isim => 'Lojistik')
    Category.create( :name => 'Architecture - Design', :isim => 'Mimarlık - Tasarım')
    Category.create( :name => 'Accounting Services', :isim => 'Muhasebe')
    Category.create( :name => 'Engineering', :isim => 'Mühendislik')
    Category.create( :name => 'Customer Relations', :isim => 'Müşteri Hizmetleri')
    Category.create( :name => 'Automotive', :isim => 'Otomotiv')
    Category.create(:name => 'Retail Services', :isim => 'Perakende - Mağazacılık')
    Category.create( :name => 'Advertisement - Public Relations', :isim => 'Reklamcılık - Halkla ilişkiler')
    Category.create( :name => 'Health Services', :isim => 'Sağlık')
    Category.create( :name => 'Sales', :isim => 'Satış')
    Category.create( :name => 'Technical Services', :isim => 'Teknik Servis')
    Category.create( :name => 'Textile', :isim => 'Tekstil')
    Category.create( :name => 'Telecommunications', :isim => 'Telekomünikasyon')
    Category.create( :name => 'Cleaning Services', :isim => 'Temizlik')
    Category.create( :name => 'Tourism', :isim => 'Turizm')
    Category.create( :name => 'Production - Operation Services', :isim => 'Üretim - Operasyon')
    Category.create( :name => 'Construction Services', :isim => 'Yapı İşleri')
    Category.create( :name => 'Food and Beverage Services', :isim => 'Yiyecek - İçecek Hizmetleri')
    Category.create( :name => 'Management - Strategic Planning', :isim => 'Yönetim - Stratejik Planlama')
    Category.create( :name => 'Other', :isim => 'Diğer')
  end

  desc "Run all bootstrapping tasks"
  task :all => [:default_categories]
  # to run all tasks: rake bootstrap:all
end
