bool isLeapYear(int year) {
  if (year % 4 == 0) {
    if (year % 100 == 0) {
      if (year % 400 == 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } else {
    return false;
  }
}
bool isDateConsecutive(DateTime prevDate,DateTime currDate){
  if(currDate.day==1){
    if(currDate.month==1){
      if(prevDate.day==31&&prevDate.month==12){
        return true;
      }else{
        return false;
      }
    }else if(currDate.month==3){
      if(prevDate.month==2){
        if(isLeapYear(prevDate.year)){
          if(prevDate.day==29){
            return true;
          }else{
            return false;
          }
        }else{
          if(prevDate.day==28){
            return true;
          }else{
            return false;
          }
        }
      }else{
        return false;
      }
    }else if(currDate.month==2||currDate.month==4||currDate.month==6||currDate.month==9||currDate.month==11){
      if(prevDate.month+1==currDate.month){
        if(prevDate.day==31){
          return true;
        }else{
          return false;
        }
      }else{
        return false;
      }
    }else{
      if(prevDate.month+1==currDate.month){
        if(prevDate.day==30){
          return true;
        }else{
          return false;
        }
      }else{
        return false;
      }
    }
  }else{
    if(prevDate.day+1==currDate.day){
      return true;
    }else{
      return false;
    }
  }
}
DateTime convertDate(DateTime date){
  return DateTime(date.year,date.month,date.day,23,59,59);
}