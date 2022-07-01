import java.util.HashMap;

public class TopicModelUtil {
    //耦合测试版
    public static native String stringFromJNI(String model_path);//为了不实例化对象直接调用方法

    //模型变量尝试，只存指针可行吗？pointer of original Data Structure to Index
    public static HashMap<Integer, Long> DS2Index = new HashMap<>();//其实short和Integer就行吧，直接用原来的不容易出bug

    //读取model.vector和vocab.marisa以初始化topic model亦即Inference Engine，读取vocab.vector以初始化tokenizer
    public static native int initTopicModelEngine(String model_path);

    //推理，输入query，输出主题分布
    public static native String[] topicDistributionInference(String query);//keywords就直接用java根据主题读文件就行了，100个为上限

    //释放模型相关变量
    public static native int releaseTopicModelEngine();


}
