using Microsoft.AspNetCore.Mvc;

namespace MES.ProcessAPI.Controllers;

/// <summary>
/// MES 产线工序命令接口
/// 对应 MES 系统「工序-产线-API映射」中的 7 个 api_command
/// </summary>
[ApiController]
public class ProcessController : ControllerBase
{
    private readonly ILogger<ProcessController> _logger;
    private static readonly Dictionary<string, string> ProcessMap = new()
    {
        ["start"]        = "原材料领料 - 启动初始化",
        ["sendstart"]    = "CNC加工 - 启动传送带",
        ["sendstop"]     = "打磨处理 - 停止传送带",
        ["startgrab"]    = "喷砂氧化 - 抓取盒子到平台",
        ["startgrabBack"]= "组装 - 抓取盒子到传送带",
        ["startcrue"]    = "功能检测 - 开始打螺丝",
        ["startlay"]     = "包装入库 - 开始激光打标",
    };

    public ProcessController(ILogger<ProcessController> logger)
    {
        _logger = logger;
    }

    /// <summary>
    /// 通用工序命令入口
    /// GET /WeatherForecast/command?commandname=start
    /// </summary>
    [HttpGet("WeatherForecast/command")]
    public IActionResult Command([FromQuery] string commandname)
    {
        if (string.IsNullOrWhiteSpace(commandname))
        {
            return BadRequest(new { code = 400, success = false, message = "commandname 不能为空" });
        }

        var name = ProcessMap.TryGetValue(commandname, out var desc) ? desc : $"未知命令: {commandname}";

        _logger.LogInformation("[MES] 收到工序命令: {Command} ({Desc}) 时间: {Time}",
            commandname, name, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));

        return Ok(new
        {
            code = 200,
            success = true,
            command = commandname,
            description = name,
            timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"),
            message = $"命令 {commandname} 已执行成功"
        });
    }

    // ======== 兼容 MES 直接路径路由（如果 MES 配置的是 /start 而不是 /WeatherForecast/command?commandname=start） ========

    [HttpGet("start")]
    public IActionResult Start() => Command("start");

    [HttpGet("sendstart")]
    public IActionResult SendStart() => Command("sendstart");

    [HttpGet("sendstop")]
    public IActionResult SendStop() => Command("sendstop");

    [HttpGet("startgrab")]
    public IActionResult StartGrab() => Command("startgrab");

    [HttpGet("startgrabBack")]
    public IActionResult StartGrabBack() => Command("startgrabBack");

    [HttpGet("startcrue")]
    public IActionResult StartCrue() => Command("startcrue");

    [HttpGet("startlay")]
    public IActionResult StartLay() => Command("startlay");

    /// <summary>
    /// 健康检查（MES 连接测试用）
    /// </summary>
    [HttpGet("health")]
    public IActionResult Health()
    {
        return Ok(new { status = "healthy", timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") });
    }
}
