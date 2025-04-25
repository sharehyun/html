
//jquery선언
$(function(){
    $("#dataOpen3").click(function(){
        $.ajax({
            url:"https://apis.data.go.kr/B551011/PhotoGalleryService1/galleryList1?serviceKey=EjhlWVXtGK399lEiK83%2BSs3Yqv1oGbVqLNhoDroklDIBsszUvHP0%2FFM%2Fwq9jFhjzggMFz6ZgTjF6de%2BlnjE7pw%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&_type=json",
            type:"get",
            data:{},
            dataType:"json",
            success:function(data){

                alert("성공");
                let hdata=``;
                let imgData = data.response.body.items.item;
                for(let i=0;i<imgData.length;i++){
                    hdata+=`<tr id="${i}">`;
                    hdata+=`<td>${imgData[i].galContentId}</td>`;
                    hdata+=`<td>${imgData[i].galCreatedtime}</td>`;
                    hdata+=`<td>${imgData[i].galPhotographer}</td>`;
                    hdata+=`<td>${imgData[i].galPhotographyLocation}</td>`;
                    hdata+=`<td>${imgData[i].galSearchKeyword}</td>`;
                    hdata+=`<td>${imgData[i].galTitle}</td>`;
                    hdata+=`<td>${imgData[i].galWebImageUrl}</td>`;
                    hdata+=`<td>`;
                    hdata+=`<button type="button" class="updateBtn">수정</button>`;
                    hdata+=`<button type="button" class="deleteBtn">삭제</button>`;
                    hdata+=`</td>`;
                    hdata+=`</tr>`;
                }
                $("#tbody").html(hdata);

            },
            error:function(){
                alert("실패");
            }
        })
    });//dataOpen3

});