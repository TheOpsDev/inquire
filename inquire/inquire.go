package inquire

type AlphaAdvantageConfig struct {
	ApiKey string
}

type OptionFunc func(*AlphaAdvantageConfig)

func SetApiKey(apiKey string) OptionFunc {
	return func(configOption *AlphaAdvantageConfig) {
		configOption.ApiKey = apiKey
	}
}

func NewAlphaAdvantageConfig(options ...OptionFunc) *AlphaAdvantageConfig {
	alphaConfig := &AlphaAdvantageConfig{
		ApiKey: "demo"
	}

	for _, option := range options {
		option(alphaConfig)
	}

	return alphaConfig
}

// func GetTimeSeriesDaily(ticker string, apiKey string) {
// 	if apiKey == "" {
// 		apiKey = os.Getenv("ALPHA_ADVANTAGE_API_KEY")
// 		log.Printf("API key successfully parsed from environment variable.")
// 	}
// }
