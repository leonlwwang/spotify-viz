# Spotify VIZ
Visualization in R using data from the Spotify Web API :chart_with_upwards_trend:

![Alt text](./plot.svg)

### Overview
This project uses the Spotify API to generate data visualizations in R. This is a project generated from the files I used for my STAT 447 project which is now a private, archived codebase. I plan to extend my work done on the old repo and add new functionality such as improved visualizations and a better interface design.

### Instructions
To replicate this visualization on your own system, all you need to do is run the `main.R` script, which will do the API calls, parsing, cleaning, and formatting to generate a pdf called `plot.pdf` into the repository. You can take a look at how all of the steps are being done by checking out the files located in the `utility` directory.

### Notes
* `auth.sh` is probably an insecure way of generating an API token because it saves the Spotify API client secret directly into the shell file. It's encoded in Base 64 when generating the token but it's still definitely not secure. The token is likely to be generated in a more secure way when authenticating in an actual web app.

* I used the [Client Credentials flow](https://developer.spotify.com/documentation/general/guides/authorization/client-credentials/) which is system authenticated rather than by the user. I plan to migrate to the [Authorization Code flow](https://developer.spotify.com/documentation/general/guides/authorization/code-flow/) which grants endpoint access for user data and can offer more unique visualizations.
