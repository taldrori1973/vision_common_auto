package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup;

import lombok.Data;

import java.util.List;

@Data
public class Tree {
    private List<Site> sites;
    private List<TreeDeviceNode> devices;
}
