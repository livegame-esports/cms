			</div>
		</div>
		<div class="navigation">
			<div class="container">
				<ul class="breadcrumb">
					{nav}
				</ul>			
			</div>
		</div>
	
		<div class="container">
			<?php if($monitoringType == 2): ?>
    <div class="table-responsive monitoring-table <?php if($monitoringType == 2): ?>big-monitoring-table<?php endif; ?>">
    <table class="table table-bordered">
        <thead>
        <tr>
            <td>Название сервера</td>
            <td>Карта</td>
            <td>Игроков</td>
            <td>IP-адрес</td>
            <td>Действия</td>
        </tr>
        </thead>
        <tbody id="servers">
        <tr>
            <td colspan="10">
                <div class="loader"></div>
                <script>get_servers();</script>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<?php else: ?>
    <div class="row">
        <div class="col-lg-3">
            <div class="logo">
                <a href="{site_host}" title="{site_name}">
                    <img src="{site_host}templates/{template}/img/logo.png" alt="{site_name}">
                </a>
            </div>
        </div>
        <?php if($monitoringType == 0): ?>
            <div class="col-lg-9 px-0 px-lg-3">
                <div class="monitoring">
    <div id="servers">
        <div class="loader"></div>
        <script>get_servers();</script>
    </div>
</div>
            </div>
        <?php else: ?>
            <div class="col-lg-9">
                <div class="table-responsive monitoring-table <?php if($monitoringType == 2): ?>big-monitoring-table<?php endif; ?>">
    <table class="table table-bordered">
        <thead>
        <tr>
            <td>Название сервера</td>
            <td>Карта</td>
            <td>Игроков</td>
            <td>IP-адрес</td>
            <td>Действия</td>
        </tr>
        </thead>
        <tbody id="servers">
        <tr>
            <td colspan="10">
                <div class="loader"></div>
                <script>get_servers();</script>
            </td>
        </tr>
        </tbody>
    </table>
</div>
            </div>
        <?php endif; ?>
    </div>
<?php endif; ?>

			<div class="row">