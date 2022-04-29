import 'dart:core';

class DateOnly{
  int year;
  int month;
  int day;

  List<int> monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  DateOnly({required this.year, required this.month, required this.day});

  ///日期增加指定的天数
  DateOnly addDays(int number){
    var temp = DateOnly(year: year, month: month, day: day);

    temp.day = temp.day + number;

    switch(temp.month){
      case 2:
        if(temp.isLeap()){
          if(temp.day > 29){
            temp.day = temp.day - 29;
          }
        }
        else{
          if(temp.day > 28){
            temp.day = temp.day - 28;
          }
        }
        temp.month = temp.month + 1;
        break;
      case 12:
        if(temp.day > 31){
          temp.day = temp.day - 31;
          temp.month = 1;
          temp.year =temp.year + 1;
        }
        break;
      default:
        if(temp.day > monthDays[temp.month - 1]){
          temp.day = temp.day - monthDays[temp.month - 1];
          temp.month = temp.month + 1;
        }
        break;
    }

    return temp;
  }

  ///判断当前年份是否为闰年
  bool isLeap(){
    if((year % 4 == 0 && year % 100 == 0) || year % 400 == 0){
      return true;
    }else{
      return false;
    }
  }

  @override
  String toString(){
    return "$year-$month-$day";
  }

  DateOnly? parse(String input){
    try{
      var result = input.split("-");
      int _year = int.parse(result[0]);
      int _month = int.parse(result[1]);
      int _day = int.parse(result[2]);

      return DateOnly(year: _year, month: _month, day: _day);
    }catch(e){
      return null;
    }

  }
}