<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="homepage.aspx.cs" Inherits="futureweb.homepage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>抽卡</title>
    <style>
        /* 主容器 Flexbox 設定 */
        .flex-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        /* 標題樣式 */
        .title {
            font-size: xx-large;
            color: #6600CC;
            margin-bottom: 20px;
            text-align: center;
        }

        /* 閃爍效果 */
        @keyframes blink {
            0% { opacity: 1; }
            50% { opacity: 0; }
            100% { opacity: 1; }
        }

        /* 提示文字樣式 */
        .blink-text {
            font-size: large;
            color: #808080;
            animation: blink 1.5s infinite;
            margin-bottom: 20px;
        }

        /* 卡片容器樣式-提供3D視角的父容器*/
        .card-container {
            position: relative;
            width: 200px;
            height: 300px;
            perspective: 1000px; /* 設置 3D 效果 */
        }

        .card {
            width: 100%;
            height: 100%;
            position: absolute;
            transform-style: preserve-3d;
            transition: transform 1s;
        }

        .card.flip {
            transform: rotateY(180deg); /* 卡片翻轉 */
        }

        .card .front,
        .card .back {
            position: absolute;
            width: 100%;
            height: 100%;
            backface-visibility: hidden;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .card .back {
            background: linear-gradient(135deg, #9b59b6, #8e44ad); /* 背面樣式 */
        }

        .card .front {
            background: linear-gradient(135deg, #ff9a9e, #fad0c4); /* 正面樣式 */
            transform: rotateY(180deg);
        }

        /* 閃亮特效 */
        .shine-effect {
            animation: shine 2s infinite alternate;
        }

        @keyframes shine {
            0% { box-shadow: 0 0 10px rgba(255, 255, 255, 0.3); }
            100% { box-shadow: 0 0 30px rgba(255, 255, 255, 0.8); }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="flex-container">
            <!-- 標題 -->
            <div class="title">
                <strong>在心中默念你的問題</strong>
            </div>

            <!-- 閃爍提示文字 -->
            <asp:Label ID="label1" runat="server" Text="點擊畫面抽取您的卡片" CssClass="blink-text"></asp:Label>

            <!-- 卡片區域 -->
            <div class="card-container" onclick="startCardProcess()">
                <div id="Panel1" class="card">
                    <!-- 卡片背面 -->
                    <div class="back">
                        <asp:Label ID="LabelBack" runat="server" Text="點擊翻面"></asp:Label>
                    </div>
                    <!-- 卡片正面 -->
                    <div class="front">
                        <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // 卡片點擊事件
            function startCardProcess() {
                const card = document.getElementById('Panel1');
                card.classList.add('shine-effect'); // 添加閃亮特效

                // 設置5秒後翻面
                setTimeout(() => {
                    card.classList.add('flip'); // 翻面
                    card.classList.remove('shine-effect'); // 移除閃亮特效
                    __doPostBack('<%= Label2.ClientID %>', '');
                }, 5000);
            }
        </script>
        <p class="auto-style1">
            <strong>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 1 [text] 
FROM [Sentence] 
ORDER BY NEWID()
"></asp:SqlDataSource>
            <asp:Button ID="backBT" runat="server" BackColor="White" ForeColor="Black" OnClick="backBT_Click" Text="回到上頁" />
            </strong>
        </p>
    </form>
</body>
</html>
