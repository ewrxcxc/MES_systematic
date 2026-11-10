var builder = WebApplication.CreateBuilder(args);

// 监听 0.0.0.0:5000，支持局域网访问
builder.WebHost.UseUrls("http://0.0.0.0:5000");

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// 允许 MES 前端跨域调用（调试用）
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

var app = builder.Build();

app.UseCors();

// 开发/生产环境都启用 Swagger，方便局域网调试
app.UseSwagger();
app.UseSwaggerUI();

app.MapControllers();

app.Run();
