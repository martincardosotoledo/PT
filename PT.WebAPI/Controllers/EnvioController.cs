using Microsoft.AspNetCore.Mvc;
using PT.DTOs;
using PT.Services;

namespace PT.WebAPI.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class EnvioController : ControllerBase
    {
        private readonly ILogger<EnvioController> _logger;

        public EnvioController(ILogger<EnvioController> logger)
        {
            _logger = logger;
        }

        [HttpGet("{id}")]
        public EnvioEdicionVistaDTO obtener(int id)
        {
            return new EnvioService().TraerParaEdicion(id);
        }

        [HttpGet("listar")]  
        public ActionResult<List<EnvioDTO>> listar()
        {
            return Ok(new EnvioService().TraerEnviosParaListar());
        }

        [HttpPatch("{id}")]
        public void ActualizarEnvio(int id, [FromBody] string nuevoEstado)
        {
            new EnvioService().ActualizarEstado(envioID: id, nuevoEstado: nuevoEstado);
        }
    }
}
