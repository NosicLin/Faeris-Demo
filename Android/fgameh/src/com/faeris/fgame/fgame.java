package com.faeris.fgame;
import com.faeris.lib.Fs_Activity;

import android.os.Bundle;
import android.view.WindowManager;
public class fgame  extends Fs_Activity
{
	@Override 
	public void onCreate(final Bundle save_state)
	{
		super.onCreate(save_state);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON, WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

	}
	
	static {
		System.loadLibrary("fmodex");
        System.loadLibrary("faeris");

    }

}
