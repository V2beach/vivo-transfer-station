import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class Main{
    static {
        System.loadLibrary("lda");
    }

    public static void main(String[] args){
        String model_path = "news/";
        long startTime = System.currentTimeMillis();
        TopicModelUtil.initTopicModelEngine(model_path);
        long endTime = System.currentTimeMillis();
        System.out.println("初始化耗时为：" + (endTime-startTime) + "ms");

        String query = "看了好多的评论,都说油耗高,本来挺喜欢的！但是又纠结了！吉利在这两年何谓风头无两,多个车型都占据国产车的半壁江山,也呈现出了和合资争雄的决心和能力。今天老司机谈一谈一款吉利的热车,sv博越！";
        String[] ans;

        startTime = System.currentTimeMillis();
        ans = TopicModelUtil.topicDistributionInference(query);
        endTime = System.currentTimeMillis();
        System.out.println("推理新文档耗时为：" + (endTime-startTime) + "ms");

        for (int i = 0; i < ans.length; i++){
            System.out.println(ans[i]);
        }

        TopicModelUtil.releaseTopicModelEngine();
    }
}
