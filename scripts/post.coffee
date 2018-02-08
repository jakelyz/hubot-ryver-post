# Description:
#
# Example declarations for robot to respond to anything, even in topic posts
#
# Requires updated ryver.coffee with new functions from lillyjsm fork

module.exports = (robot) ->

  robot.hear /example/i, (res) ->
    if typeof res.envelope.message.user != "number"
      res.send("Responding to example regex")
      
    else
      user = process.env.HUBOT_RYVER_USERNAME
      pass = process.env.HUBOT_RYVER_PASSWORD
      topicID = res.envelope.message.user
      auth = 'Basic ' + new Buffer(user+':'+pass).toString('base64')
      data = '{"comment":"Responding to example regex","post":{"id":'+topicID+'}}'
      robot.http('https://exampleorg.ryver.com/api/1/odata.svc/postComments')
      .headers(Authorization: auth, 'Content-Type': 'application/json', 'Accept': 'application/json')
      .post(data) (err, response, body) ->
        console.log(err)
