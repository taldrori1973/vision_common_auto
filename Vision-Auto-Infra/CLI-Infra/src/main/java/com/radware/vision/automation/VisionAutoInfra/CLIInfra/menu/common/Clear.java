package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * 
 * @author Hadar Elbaz
 */

public class Clear extends Builder{
	
	public Clear(String prefix) {
		super(prefix);
	}

	
	@Override
	public String getCommand() {
		return " clear";
	}
}