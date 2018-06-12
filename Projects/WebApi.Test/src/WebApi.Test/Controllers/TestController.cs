using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebApi.Test.Contract;

namespace WebApi.Test.Controllers
{
    [Route("api/test")]
    public class TestController : Controller
    {
        // GET api/test/ping?echo=hello
        [HttpGet("ping")]
        public IActionResult Ping(string echo)
        {
            return Ok(
                        new PingResponse
                        {
                            Echo = echo + " is the echo back",
                            CurrentTime = DateTime.Now
                        }
                     );
        }
    }
}
