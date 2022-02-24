<?php

class Polls {
	private $pdo;
	private $tpl;
	
	function __construct($pdo, $tpl = null, $dir = 'modules_extra/polls/templates/') {
		if (!isset($pdo)) {
			return '[Class Widgets]: No connection to the database';
		}
		
		$this->tpl = new Template;
		$this->tpl->dir = $dir;
		
		$this->pdo = $pdo;
	}
	
	public function poll_small($pollid) {
		if(!isset($_SESSION['id'])) {
			return '';
		}
		
		$pollid = check($pollid, "int");
		
		$this->tpl->result['local_content'] = '';
		
		$STH = $this->pdo->query("SELECT * FROM `poll` WHERE `id` = {$pollid}");
		$poll = $STH->fetch(PDO::FETCH_ASSOC);
		
		if(empty($poll)) {
			return '<span class="empty-element">Опрос не существует</span>';
		}
		
		$STH = $this->pdo->query("SELECT count(id) as `count`, `poll` FROM `poll_answer` WHERE `pollid` = {$pollid} GROUP BY `poll`");
		$answer = $STH->fetchAll(PDO::FETCH_ASSOC);
		
		$STH = $this->pdo->query("SELECT `id` FROM `poll_answer` WHERE `pollid` = {$pollid} AND `userid`={$_SESSION['id']}");
		$answered = $STH->fetch() ? 1:0;
		
		$polls = json_decode($poll['polls']);
		
		$count = 0;
		if( $answer ) {
			$count = array_sum(array_column($answer,'count'));
			$summ = 100 / $count;
		}
		
		$row_type = $answered ? 'row_ok.tpl':'row.tpl';
		
		foreach( $polls as $k => $val ) {
			$this->tpl->load_template($row_type);
			
			$id = ($k+1);
			
			$polldata = "onclick=\"poll_answer({$pollid},{$id},'poll_small',this)\"";
			
			$this->tpl->set("{id}", $id);
			$this->tpl->set("{poll}", $val);
			$this->tpl->set("{answer}", $answered );
			$this->tpl->set("{pollid}",  $pollid);
			$this->tpl->set("{polldata}", $polldata );
			
			if( $answer && ( $get = array_search( $id, array_column($answer,'poll') ) ) !== false ) {
				$this->tpl->set("{count}", $answer[$get]['count'] );
				$this->tpl->set("{percent}", $summ*$answer[$get]['count']);
			} else {
				$this->tpl->set("{count}", 0 );
				$this->tpl->set("{percent}", 0 );
			}
			
			$this->tpl->compile('rows');
			$this->tpl->clear();
		}
		
		
		$this->tpl->load_template('widget_small.tpl');
		$this->tpl->set("{name}", $poll['name']);
		$this->tpl->set("{answer}", $answered );
		$this->tpl->set("{rows}", $this->tpl->result['rows']);
		$this->tpl->set("{count}", $count);
		$this->tpl->compile('local_content');
		$this->tpl->clear();
		
		return $this->tpl->result['local_content'];
	}
}