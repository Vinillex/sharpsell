import 'dart:convert';

class ComicPageData {

    ComicPageData({
        this.month,
        this.num,
        this.link,
        this.year,
        this.news,
        this.safeTitle,
        this.transcript,
        this.alt,
        this.img,
        this.title,
        this.day,
    });

    factory ComicPageData.fromRawJson(String str) => ComicPageData.fromJson(json.decode(str) as Map<String,dynamic>);

    factory ComicPageData.fromJson(Map<String, dynamic> json) => ComicPageData(
        month: json['month'] as String?,
        num: json['num'] as int?,
        link: json['link'] as String?,
        year: json['year'] as String?,
        news: json['news'] as String?,
        safeTitle: json['safe_title'] as String?,
        transcript: json['transcript'] as String?,
        alt: json['alt'] as String?,
        img: json['img'] as String?,
        title: json['title'] as String?,
        day: json['day'] as String?,
    );
    final String? month;
    final int? num;
    final String? link;
    final String? year;
    final String? news;
    final String? safeTitle;
    final String? transcript;
    final String? alt;
    final String? img;
    final String? title;
    final String? day;

    ComicPageData copyWith({
        String? month,
        int? num,
        String? link,
        String? year,
        String? news,
        String? safeTitle,
        String? transcript,
        String? alt,
        String? img,
        String? title,
        String? day,
    }) => 
        ComicPageData(
            month: month ?? this.month,
            num: num ?? this.num,
            link: link ?? this.link,
            year: year ?? this.year,
            news: news ?? this.news,
            safeTitle: safeTitle ?? this.safeTitle,
            transcript: transcript ?? this.transcript,
            alt: alt ?? this.alt,
            img: img ?? this.img,
            title: title ?? this.title,
            day: day ?? this.day,
        );

    String toRawJson() => json.encode(toJson());

    Map<String, dynamic> toJson() => {
        'month': month,
        'num': num,
        'link': link,
        'year': year,
        'news': news,
        'safe_title': safeTitle,
        'transcript': transcript,
        'alt': alt,
        'img': img,
        'title': title,
        'day': day,
    };
}
