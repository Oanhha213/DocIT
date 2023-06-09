﻿using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc;
namespace demo.Models.Authentication
{
    public class Authentication : ActionFilterAttribute
    {
        public override void OnActionExecuted(ActionExecutedContext context)
        {      
            if (context.HttpContext.Session.GetString("UserName") == null){
                context.Result = new RedirectToRouteResult(
                    new RouteValueDictionary() {
                        { "Controller","Access"},
                        {"Action","Login" }
                    });
            }
        }
    }
}
