package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.delete;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by urig on 3/3/2016.
 */
public class Delete extends Builder {

    public Delete(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " delete";
    }

}