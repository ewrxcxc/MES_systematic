package com.ruoyi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.jdbc.autoconfigure.DataSourceAutoConfiguration;

/**
 * 启动程序
 * 
 * @author ruoyi
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class MESApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(MESApplication.class, args);
        System.out.println("\n" +
                "  ╔══════════════════════════════════════╗\n" +
                "  ║      MES 智能制造执行系统              ║\n" +
                "  ║      Manufacturing Execution System   ║\n" +
                "  ║      Version 1.0.0                     ║\n" +
                "  ╚══════════════════════════════════════╝\n");
    }
}