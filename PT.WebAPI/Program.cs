using NHibernate;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped(factory => PT.DataAccess.SessionManager._sessionFactory.OpenSession());
//builder.Services.AddScoped<IMapperSession, NHibernateMapperSession>();


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();
new PT.Inicializacion.InicializacionService().Inicializar(builder.Environment.ContentRootPath);

// Añadir el middleware de NHibernate
app.UseMiddleware<NHibernateSessionMiddleware>();

app.MapControllers();


app.Run();


public class NHibernateSessionMiddleware
{
    private readonly RequestDelegate _next;

    public NHibernateSessionMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task Invoke(HttpContext context, NHibernate.ISession session)
    {
        try
        {
            // Hacer el bind de la sesión a NHibernate en el contexto actual
            NHibernate.Context.CurrentSessionContext.Bind(session);

            await _next(context); // Pasa la solicitud al siguiente middleware

            // Confirmar la transacción si todo salió bien
            if (session.Transaction.IsActive)
            {
                await session.Transaction.CommitAsync();
            }
        }
        catch
        {
            // Rollback en caso de error
            if (session.Transaction.IsActive)
            {
                await session.Transaction.RollbackAsync();
            }

            throw;
        }
        finally
        {
            // Hacer unbind y cerrar la sesión
            NHibernate.Context.CurrentSessionContext.Unbind(session.SessionFactory);
            session.Close();
        }
    }
}