using System;
using System.Data.Entity;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using Microsoft.Practices.Unity;
using PartsUnlimited.Utils;
using Unity.Mvc4;

// demo change
// another change
// demo more changes - again again
// some other change - Steve removed this!
namespace PartsUnlimited
{
	// some change in master
    public class Global : HttpApplication
    {
		// some other chanbge
        internal static IUnityContainer UnityContainer;

        protected void Application_Start(object sender, EventArgs e)
        {
            // change in common1
            AreaRegistration.RegisterAllAreas();
            System.Console.WriteLine("In Global");

            Database.SetInitializer(new PartsUnlimitedDbInitializer());

            UnityContainer = UnityConfig.BuildContainer();
            DependencyResolver.SetResolver(new UnityDependencyResolver(UnityContainer));

            RouteConfig.RegisterRoutes(RouteTable.Routes);
            WebApiConfig.RegisterWebApi(GlobalConfiguration.Configuration, UnityContainer);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}