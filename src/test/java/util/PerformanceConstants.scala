package util

object PerformanceConstants {
  def numOfUsers = 3
  def successThreshold = 100
  def duration = 200 // in seconds

  def secondMillis = 1000
  val (mean, percentile_75, percentile_95) = {  ( ( 1.2* secondMillis).toInt,   ( 1.2* secondMillis).toInt,  ( 1.4* secondMillis).toInt) }

}
