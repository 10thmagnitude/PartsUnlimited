using System.Threading.Tasks;
using System.Web.Mvc;
using PartsUnlimited.ProductSearch;
using PartsUnlimited.Utils;
using System.Collections.Generic;
using System.Linq;
using System;

namespace PartsUnlimited.Controllers
{
    public class SearchController : Controller
    {
        private readonly IProductSearch search;
		private readonly ITelemetryProvider telemetryProvider;


		public SearchController(IProductSearch search, ITelemetryProvider telemetryProvider)
        {
            this.search = search;
			this.telemetryProvider = telemetryProvider;
        }

        [HttpGet]
        public async Task<ActionResult> Index(string q)
        {
            var result = await search.Search(q);
			var count = q == "jumper" ? 0 : new Random().Next(3, 7);

			telemetryProvider.TrackEvent("Search", 
				new Dictionary<string, string>() { { "term", q } }, new Dictionary<string, double>() { { "count", count } });

            return View(result);
        }
    }
}
