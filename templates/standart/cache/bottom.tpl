					</div>
				</div>
			</div>
			<div class="footer">
				<div class="container">
					<div class="row">
						<div class="col-lg-5">
							<a href="{site_host}" title="{site_name}">
								<img src="{site_host}templates/{template}/img/logo.png" alt="{site_name}">
							</a>
							<p>
								<?php echo $footer_description; ?>
							</p>

							<hr class="my-3 d-block d-lg-none">
						</div>
						<div class="col-lg-2 col-6">
							<strong>
								Навигация
							</strong>
							<ul>
								<?php for($i=0; $i < count($vertical_menu_2); $i++): ?>  
								<li>
									<a href="<?php echo $vertical_menu_2[$i]['link']; ?>" title="<?php echo $vertical_menu_2[$i]['name']; ?>"><?php echo $vertical_menu_2[$i]['name']; ?></a>
								</li>
								<?php endfor; ?>
							</ul>
						</div>
						<div class="col-lg-2 col-6">
							<strong>
								Проект
							</strong>
							<ul>
								<?php for($i=0; $i < count($vertical_menu_3); $i++): ?>  
								<li>
									<a href="<?php echo $vertical_menu_3[$i]['link']; ?>" title="<?php echo $vertical_menu_3[$i]['name']; ?>"><?php echo $vertical_menu_3[$i]['name']; ?></a>
								</li>
								<?php endfor; ?>
							</ul>
						</div>
						<div class="col-lg-3">
							<strong>
								Полезные ссылки
							</strong>
							<ul>
								<?php for($i=0; $i < count($vertical_menu_4); $i++): ?>  
								<li>
									<a href="<?php echo $vertical_menu_4[$i]['link']; ?>" title="<?php echo $vertical_menu_4[$i]['name']; ?>"><?php echo $vertical_menu_4[$i]['name']; ?></a>
								</li>
								<?php endfor; ?>
							</ul>
							<?php if($conf->cote == 1): ?>
								<div id="cote" onclick="click_cote();"><img src="{site_host}/ajax/sound/cote1.gif"></div>
							<?php endif; ?>
						</div>

						<div class="col-lg-12">
							<hr class="my-3">
						</div>

						<div class="col-lg-8 copyright">
							<p><a href="{site_host}" title="{site_name}">{site_name}</a> © Все права защищены</p>
						</div>
						<div class="col-lg-4 banners">
							<?php for($i=0; $i < count($footer_banners); $i++): ?>  
							<a href="<?php echo $footer_banners[$i]['link']; ?>" target="_blank">
								<img src="<?php echo $footer_banners[$i]['img']; ?>" alt="banner">
							</a>
							<?php endfor; ?>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script src="{site_host}templates/{template}/js/lightbox.js"></script>
		<script>
			window.onload = function () {
				$('[tooltip="yes"]').tooltip();
				$('[data-toggle="dropdown"]').dropdown();
			};
		</script>
	</body>