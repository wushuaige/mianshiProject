package o;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.io.File;
import java.util.ArrayList;
import java.util.List;



public class GeneratorSqlMap {
    public void generator() throws Exception{
        List<String> warnings = new ArrayList<>();
        boolean overwrite = true;
        File configFile = new File("D:\\all_Github_Project\\mianshiProject\\generatorSqlmapCustom\\generatorConfig.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config =cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config,callback,warnings);
        myBatisGenerator.generate(null);
    }

    public static void main(String [] args)throws Exception{
        try{
            GeneratorSqlMap generatorSqlMap = new GeneratorSqlMap();
            generatorSqlMap.generator();
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
