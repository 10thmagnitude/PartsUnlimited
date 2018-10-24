using Microsoft.Practices.Unity;
using PartsUnlimited.Models;
using PartsUnlimited.ProductSearch;
using PartsUnlimited.Recommendations;
using PartsUnlimited.Telemetry;
using PartsUnlimited.Utils;
using System.Collections.Generic;
using System.Web.Configuration;

namespace PartsUnlimited
{
    public class UnityConfig
    {
        public static UnityContainer BuildContainer()
        {
            var container = new UnityContainer();

            container.RegisterType<IPartsUnlimitedContext, PartsUnlimitedContext>();
            container.RegisterType<IOrdersQuery, OrdersQuery>();
            container.RegisterType<IRaincheckQuery, RaincheckQuery>();
            container.RegisterType<IRecommendationEngine, AzureMLFrequentlyBoughtTogetherRecommendationEngine>();
            container.RegisterType<ITelemetryProvider, AppInsightsTelemetryProvider>(new InjectionConstructor(GetTelemetryProperties()));
            container.RegisterType<IProductSearch, StringContainsProductSearch>();

            container.RegisterInstance<IHttpClient>(container.Resolve<HttpClientWrapper>());

            return container;
		}

		private static Dictionary<string, string> GetTelemetryProperties()
		{
			return new Dictionary<string, string>()
			{
				{ "Environment", WebConfigurationManager.AppSettings["Environment"] },
				{ "SlotName", WebConfigurationManager.AppSettings["SlotName"] },
				{ "Version", typeof(UnityConfig).Assembly.GetName().Version.ToString() },
			};
		}
    }
}