#/bin/bash

export SONAR_HOST_URL='https://sonarqube.com'
export SONAR_ORGANIZATION='dadrus-github'

if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo "Building and analyzing a regular branch"
  
  if [ "$TRAVIS_BRANCH" == "master" ]; then
    mvn verify sonar:sonar \
	  -Dsonar.organization=$SONAR_ORGANIZATION \
	  -Dsonar.host.url=$SONAR_HOST_URL \
	  -Dsonar.login=$SONAR_TOKEN
  else
    mvn verify sonar:sonar \
	  -Dsonar.organization=$SONAR_ORGANIZATION \
	  -Dsonar.host.url=$SONAR_HOST_URL \
	  -Dsonar.login=$SONAR_TOKEN \
	  -Dsonar.branch=$TRAVIS_BRANCH
  fi
elif [ "$TRAVIS_PULL_REQUEST" == "true" ] && [ -n "${SONAR_TOKEN}" ]; then
  echo "Building and analyzing an internal pull request from $TRAVIS_PULL_REQUEST_BRANCH branch"
  
  mvn verify sonar:sonar \
    -Dsource.skip=true \
    -Dsonar.analysis.mode=preview \
	-Dsonar.organization=$SONAR_ORGANIZATION \
    -Dsonar.github.pullRequest=$TRAVIS_PULL_REQUEST \
    -Dsonar.github.repository=$TRAVIS_PULL_REQUEST_SLUG \
    -Dsonar.github.oauth=$SONAR_GITHUB_TOKEN \
    -Dsonar.host.url=$SONAR_HOST_URL \
    -Dsonar.login=$SONAR_TOKEN
else
  # external pull request. No Sonar analysis possible
  echo 'Build external pull request'

  mvn verify
fi