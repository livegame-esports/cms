
<!-- Start elements/visit_user.tpl -->
<a target="_blank" href="../profile?id={user_id}" id="visit_user{user_id}" style="color: {gp_color}"  data-container="body" data-toggle="popover" data-placement="top" data-content="<img class='popover_avatar' src='../{avatar}'>">{login}<script>$('#visit_user{user_id}').popover({ html: true, animation: true, trigger: "hover" });</script></a>
<!-- End elements/visit_user.tpl -->
