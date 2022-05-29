# Speech Melody Metter
Speech Melody metter is software for estimating the statistical characteristics of speech melody.

It's part of Intontrainer project
https://intontrainer.by/

## Installation

Currently on our website (see https://intontrainer.by ) the SRM prototype is uploaded, available for free download.

## Build from source

Use QT Creator or CMake to build Speech Rate Meter.
You need to build Inton Core library first.

```bash
git clone https://github.com/zhitko/speech-melody-meter.git

cd speech-melody-meter
git clone git@github.com:zhitko/inton-core.git

cmake --build . --target all```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Authors

Development:
* [Zhitko Vladimir](https://www.linkedin.com/in/zhitko-vladimir-92662255/)

Scientific:
* [Boris Lobanov](https://www.linkedin.com/in/boris-lobanov-50628384/)

## License
[MIT](https://choosealicense.com/licenses/mit/)
