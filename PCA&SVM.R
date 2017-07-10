# Excelファイル読み込み用ライブラリ
library(readxl)
df <- read_excel("~/Documents/R/svm2用データまとめmini.xlsx")

#主成分分析用サブデータフレーム
#null成分とラベルの削除
df.pca = subset(df, select = c(-No., -connect_Num, -holes_Num, -area_Holes, -Euler_number, -WORKNO, -Class))

#主成分分析の実行
pca <- prcomp(df.pca, scale = TRUE)

#第5主成分までの各データの係数を格納
rot5 = subset(pca$x, select = c(PC1:PC5))

#教師ラベルの付与
label = subset(df, select = Class)
data <- cbind(rot5, label)

#svmでloocv
library(e1071)
k <- nrow(data)
model <- svm(Class ~ ., data = data, kernel = "radial", type = "C-classification", cross = k)

#svmの結果表示
summary(model)