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

        /* 提示文字樣式 */
        .blink-text {
            font-size: large;
            color: #808080;
            animation: blink 1.5s infinite;
            margin-bottom: 20px;
        }

        /* 閃爍效果 */
        @keyframes blink {
            0% { opacity: 1; }
            50% { opacity: 0; }
            100% { opacity: 1; }
        }

        /* 卡片容器樣式 */
        .card-container {
            position: relative;
            width: 400px;
            height: 600px;
            perspective: 1000px;
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
            color: black;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* 背面樣式 */
        .card .back {
            background: linear-gradient(135deg, #ff9a9e, #fad0c4);
        }

        .card .back.shine-effect {
            animation: shine 3s infinite alternate, gradient-shift 5s infinite;
        }

        /* 正面樣式 */
        .card .front {
            background: white;
            transform: rotateY(180deg);
        }

        /* 動態漸層動畫 */
        @keyframes gradient-shift {
            0% {
                background: linear-gradient(135deg, #ff9a9e, #fad0c4);
            }
            50% {
                background: linear-gradient(135deg, #fad0c4, #a1c4fd);
            }
            100% {
                background: linear-gradient(135deg, #a1c4fd, #ffdde1);
            }
        }

        /* 光影效果 */
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
                        <asp:Label ID="LabelBack" runat="server" Text="點擊翻面" ForeColor="white"></asp:Label>
                    </div>
                    <!-- 卡片正面 -->
                    <div class="front">
                        <asp:Label ID="Label2" runat="server" ForeColor="Black" Font-Size="X-Large"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function startCardProcess() {
                const cardBack = document.querySelector('#Panel1 .back'); // 獲取卡片背面
                const card = document.getElementById('Panel1'); // 獲取整個卡片
                cardBack.classList.add('shine-effect'); // 添加閃亮特效到背面

                // 設置5秒後翻面
                setTimeout(() => {
                    card.classList.add('flip'); // 翻面
                    cardBack.classList.remove('shine-effect'); // 移除背面的閃亮特效
                    __doPostBack('<%= Label2.ClientID %>', '');
                }, 5000);
            }
        </script>
        <p>
            <asp:SqlDataSource 
                ID="SqlDataSource1" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT TOP 1 [text] FROM [Sentence] ORDER BY NEWID()">
            </asp:SqlDataSource>
            <asp:Button 
                ID="backBT" 
                runat="server" 
                BackColor="White" 
                ForeColor="Black" 
                OnClick="backBT_Click" 
                Text="回到上頁" />
        </p>
    </form>
</body>
</html>
