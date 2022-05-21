<?php
/*
'软件名称：英皇CMS（Yhcms）
'官方网站：http://www.yhcms.cc/
'--------------------------------------------------------
'Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
'遵循Apache2开源协议发布，并提供免费使用。
'--------------------------------------------------------
*/
if (!defined('BASEPATH')) exit('No direct script access allowed');
class Mydb extends CI_Model{

    function __construct (){
		parent:: __construct ();
		//加载数据库连接
		$this->load->database();
		//加载模版
		$this->load->get_templates();
	}

    //SQL语句查询
    function get_sql($sql){
        $query=$this->db->query($sql);
	    return $query->result_array();
	}

    //SQL语句查询总数量
    function get_sql_nums($sql='')  {
    	$nums = 0;
        if(!empty($sql)){
		    preg_match('/select\s*(.+)from /i', strtolower($sql),$sqlarr);
		    if(!empty($sqlarr[1])){
               $sql = str_replace($sqlarr[1],' count(*) as counta ',strtolower($sql));
			   $rows = $this->db->query($sql)->result_array();
			   $nums = $rows ? (int)$rows[0]['counta'] : 0;
		    }else{
			   $query = $this->db->query($sql);
			   $nums = (int)$query->num_rows();
		    }
        }
        return $nums;
	}

    //查询总数量
    function get_nums($table,$arr='',$like=''){
        if(!empty($arr)){
            foreach($arr as $k=>$v){
			    if(strpos($v,',') !== false && preg_match('/^([0-9]+[,]?)+$/', $v)){
				    $v = explode(',',$v);
                    $this->db->where_in($k,$v); //条件
				}elseif(substr($v,0,3)=='or|'){
					$this->db->or_where($k,substr($v,3)); //条件
			    }else{
                    $this->db->where($k,$v); //条件
			    }
		    }
        }
        if(!empty($like)){
            foreach ($like as $k=>$v){
               $this->db->like($k,$v); //搜索条件
		    }
        }
        $this->db->select('count(*) as count');
	    $rows = $this->db->get($table)->row_array();
	    $nums = $rows ? (int)$rows['count'] : 0;
        return $nums;
	}

    //查询字段总和
    function get_sum($table,$field,$arr='',$like=''){
        if(!empty($arr)){
            foreach($arr as $k=>$v){
			    if(strpos($v,',') !== false && preg_match('/^([0-9]+[,]?)+$/', $v)){
				    $v = explode(',',$v);
                    $this->db->where_in($k,$v); //条件
				}elseif(substr($v,0,3)=='or|'){
					$this->db->or_where($k,substr($v,3)); //条件
			    }else{
                    $this->db->where($k,$v); //条件
			    }
		    }
        }
        if($like){
            foreach ($like as $k=>$v){
               $this->db->like($k,$v); //搜索条件
		    }
        }
	    $rows = $this->db->select('sum('.$field.') as num')->get($table)->row_array();
	    $nums = $rows ? $rows['num'] : 0;
        return $nums;
	}

    //按条件查询单一数组
    function get_row($table,$arr='',$field='*',$order=''){
        if(is_array($arr)){
            foreach ($arr as $k=>$v){
				if(strpos($v,',') !== false && preg_match('/^([0-9]+[,]?)+$/', $v)){
					$v = explode(',',$v);
	                $this->db->where_in($k,$v); //条件
				}else{
	                $this->db->where($k,$v); //条件
				}
			}
        }else{
            $this->db->where('id',$arr);
		}
	    $this->db->select($field);
	   	if($order != '') $this->db->order_by($order); //排序
	    return $this->db->get($table)->row_array();
	}

    //生成查询列表结果，带分页
    function get_select($table,$arr='',$field='*',$order='id DESC',$limit='15',$like='',$group=''){
		if(!empty($arr)){
			foreach ($arr as $k=>$v){
				if(strpos($v,',') !== false && preg_match('/^([0-9]+[,]?)+$/', $v)){
					$v = explode(',',$v);
					$this->db->where_in($k,$v); //条件
				}elseif(substr($v,0,3)=='or|'){
					$this->db->or_where($k,substr($v,3)); //条件
				}else{
					$this->db->where($k,$v); //条件
				}
			}
		}
		if($like){
			foreach ($like as $k=>$v){
				if(substr($v,0,3)=='or|'){
					$this->db->or_like($k,substr($v,3)); //条件
				}else{
					$this->db->like($k,$v); //搜索条件
				}
			}
		}
		if(!empty($group)) $this->db->group_by($group);
		$this->db->select($field); //查询字段
		if(is_array($limit)){
			$this->db->limit($limit[0],$limit[1]);  //分页
		}else{
			$this->db->limit($limit);  //分页
		}
		if(is_array($order)){
			for($i=0; $i < sizeof($order)/2; $i++) {
				$this->db->order_by($order[2*$i],$order[2*$i+1]);
			}
		}else{
			$this->db->order_by($order); //排序
		}
		return $this->db->get($table)->result_array();
	}

    //增加
    function get_insert($table,$arr){
        if($arr){
	        $this->db->insert($table,$arr);
            $ids = $this->db->insert_id();
		    return $ids;
        }else{
		    return false;
        }
	}

    //修改
    function get_update($table,$arr,$id,$field='id'){
        if(!empty($id)){
	        if(is_array($id)){
	        	foreach ($id as $k=>$v){
					$this->db->where($k,$v);
				}
			}elseif(preg_match('/^([0-9]+[,]?)+$/',$id)){
				$id = explode(',',$id);
		        $this->db->where_in($field,$id);
	        }else{
		        $this->db->where($field,$id);
	        }
	        if($this->db->update($table,$arr)){
	            return true;
            }else{
		        return false;
            }
        }else{
		    return false;
        }
    }

    //删除
    function get_del($table,$id,$field='id'){
        if(is_array($id)){
        	foreach ($id as $k=>$v){
				$this->db->where($k,$v);
			}
	    }elseif(preg_match('/^([0-9]+[,]?)+$/',$id)){
	    	$id = explode(',',$id);
	        $this->db->where_in($field,$id);
        }else{
	        $this->db->where($field,$id);
        }
        if($this->db->delete($table)){
            return true;
        }else{
	        return false;
        }
	}
}