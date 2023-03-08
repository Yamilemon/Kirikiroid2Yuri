package com.yuri.kirikiri2;
import org.tvp.kirikiri2.KR2Activity;

public class MainActivity extends KR2Activity {
	static {
		System.loadLibrary("krkr2yuri");
	}
	@Override
	public int get_res_sd_operate_step() { return R.drawable.sd_operate_step; }
}
