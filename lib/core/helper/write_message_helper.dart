class WriteMessageHelper {
  static String writeMessageToPhoneToGetSubscription(
      int subscription, int paid, int remaining) {
    return """
*حضانة تسنيم الخاصة*


نحيط حضرتكم علماً بأن اشتراك الطالب هو $subscription جنيه.
والمبلغ المدفوع هو $paid جنيه.
*والمبلغ المتبقي هو $remaining جنيه.*

فيرجى السداد المبلغ المتبقي في أقرب وقت ممكن.
شكراً لتعاونكم
""";
  }
}
