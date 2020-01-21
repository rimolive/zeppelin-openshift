Feature: Common Zeppelin tests

  Scenario: Check if zeppelin is running
    When container is ready
    Then check that port 8080 is open