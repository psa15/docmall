package com.docmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.docmall.domain.ChartVO;
import com.docmall.mapper.ChartMapper;
import com.docmall.service.ChartService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/admin/chart/*")
@Controller
@Log4j
public class ChartController {
	
	@Setter(onMethod_ = @Autowired)
	private ChartService chartService;
	
	//1차 카테고리 별 통계 차트
	@GetMapping("/overall")
	public void overall(Model model) {
		
		/*
		 통계 차트 데이터 : 파이 차트
		 2차원 배열 구조
		 var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'], //타이틀
          ['Work',     11],	//범례 , 값
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);
		 */
		
		List<ChartVO> primary_list = chartService.primaryChart();
		
		log.info("1차 카테고리 별 구매 결과: " + primary_list);
		
		String primaryData = "[";
		primaryData +=			"['1차 카테고리', '매출'],";
		
		int i=0;
		for(ChartVO vo : primary_list) {
			primaryData += "['" + vo.getPrimary_cd() + "', " + vo.getSales_p() + "]";
			i++;
			
			//마지막 데이터 처리시 콤마(,)는 추가 안함
			if( i < primary_list.size()) primaryData += ",";
		}
		
		primaryData += "]";
		
		log.info(primaryData);
		model.addAttribute("primaryData", primaryData);
	}

}
