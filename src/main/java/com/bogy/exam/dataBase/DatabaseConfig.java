package com.bogy.exam.dataBase;


import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.boot.context.embedded.ServletRegistrationBean;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Component;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;

/**
 *
 * @ClassName:  DatabaseConfig
 * @Description: mybatis相关配置
 * @author: 秦光燿
 * @date:   2017年10月10日 上午10:00:54
 *
 */
@Component
@Configuration
public class DatabaseConfig {

    /**
     *
     * @Title: getDataSource
     * @Description: 数据源的配置
     * @param: @return
     * @return: DataSource
     * @throws
     */
    @Bean
    @ConfigurationProperties(prefix = "spring.datasource.jy")
    public DataSource getDataSource() {
        return new DruidDataSource();
    }

    /**
     *
     * @Title: sqlSessionFactory
     * @Description: mybatis的sqlSessionFactory配置
     * @param: @param dataSource
     * @param: @return
     * @param: @throws Exception
     * @return: SqlSessionFactory
     * @throws
     */
    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource)
            throws Exception {

        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource);
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        sqlSessionFactoryBean
                .setMapperLocations(resolver
                        .getResources("classpath*:com/bogy/exam/mapper/*Mapper.xml"));
        sqlSessionFactoryBean
                .setTypeAliasesPackage("com.bogy.exam.entity");
        return sqlSessionFactoryBean.getObject();
    }

    /**
     *
     * @Title: mapperScannerConfigurer
     * @Description: mapper接口扫描包
     * @param: @return
     * @return: MapperScannerConfigurer
     * @throws
     */
    @Bean
    public MapperScannerConfigurer mapperScannerConfigurer() {
        MapperScannerConfigurer mapperScannerConfigurer = new MapperScannerConfigurer();
        mapperScannerConfigurer
                .setBasePackage("com.bogy.exam.dao");
        return mapperScannerConfigurer;
    }

    /**
     *
     * @Title: transactionManager
     * @Description: 配置事务管理器
     * @param: @param dataSource
     * @param: @return
     * @param: @throws Exception
     * @return: DataSourceTransactionManager
     * @throws
     */
    @Bean
    public DataSourceTransactionManager transactionManager(DataSource dataSource)
            throws Exception {
        return new DataSourceTransactionManager(dataSource);
    }


    @Bean
    public ServletRegistrationBean druidServlet() {
        ServletRegistrationBean servletRegistrationBean = new ServletRegistrationBean(new StatViewServlet(), "/druid/*");
        // IP白名单
        servletRegistrationBean.addInitParameter("allow", "192.168.0.34,127.0.0.1");
        // IP黑名单(共同存在时，deny优先于allow)
        servletRegistrationBean.addInitParameter("deny", "192.168.1.100");
        //控制台管理用户
        servletRegistrationBean.addInitParameter("loginUsername", "admin");
        servletRegistrationBean.addInitParameter("loginPassword", "admin");
        //是否能够重置数据 禁用HTML页面上的“Reset All”功能
        servletRegistrationBean.addInitParameter("resetEnable", "false");
        return servletRegistrationBean;
    }
}  