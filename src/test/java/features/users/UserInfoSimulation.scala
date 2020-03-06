package features.users

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import util.PerformanceConstants

import scala.concurrent.duration._

class UserInfoSimulation extends Simulation {

  def urlPattern = "GET /my-service-url/users/{id}/info"

  val protocol = karateProtocol(
    "/my-service-url/users/{id}/info" -> Nil  // It will ensure that different user_ids are not taken as different URL
  )

  val  user1 = scenario("abc").exec(karateFeature("classpath:features/users/user-info.feature))
  val  userAddress = scenario("def").exec(karateFeature("classpath:features/user/user-address.feature"))

  setUp(
    user1.inject(  constantConcurrentUsers(PerformanceConstants.numOfUsers)  during (PerformanceConstants.duration seconds)  ).protocols(protocol)
  ).assertions(details(urlPattern).responseTime.mean.lte(PerformanceConstants.mean),
    details(  urlPattern).responseTime.percentile2.lte(PerformanceConstants.percentile_75),
    details( urlPattern).responseTime.percentile3.lte(PerformanceConstants.percentile_95)
  )

}
