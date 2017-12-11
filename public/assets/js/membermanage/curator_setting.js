// $(document).ready(function () {
//     $('#backFromSettingCurators').on('click', function () {

//         $('#backCreateMember').attr('action', "manager/members/create");
        
//         $("#backFromSettingCurators").attr('type', 'submit');
        
//         $('#backFromSettingCurators').on('click', function () {
//             $('#backCreateMember').submit();
//         });

//     });
// });
    
document.getElementById("createCurator").onclick = function () {

    location.href = "manager/curators/create";
        
};