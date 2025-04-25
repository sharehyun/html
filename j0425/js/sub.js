$(function(){
    $("#dataOpen").click(function(){
        //ajax선언
        $.ajax({
            url:"js/board.json",      //서버에서 받아올 url 주소
            type:"get",  //get, post
            data:{},     //웹->서버로 보내는 데이터
            dataType:"json",  //리턴해줄 타입
            success:function(data){
                alert("성공");
                console.log(data);

                let hdata=``;
                for(let i=0;i<data.length;i++){
                    hdata+=`<tr id="${data[i].bno}">`;
                    hdata+=`<td>${data[i].bno}</td>`;
                    hdata+=`<td>${data[i].title}</td>`;
                    hdata+=`<td>${data[i].id}</td>`;
                    hdata+=`<td>${data[i].bdate}</td>`;
                    hdata+=`<td>${data[i].bhit}</td>`;
                    hdata+=`<td>`;
                    hdata+=`<button type="button" class="updateBtn">수정</button>`;
                    hdata+=`<button type="button" class="deleteBtn">삭제</button>`;
                    hdata+=`</td>`;
                    hdata+=`</tr>`;
                }
                $("#tbody").html(hdata);
            },//dataOpen success
            error:function(){
                alert("실패")
            }

        });//ajax
    });//dataOpen 


});//jquery