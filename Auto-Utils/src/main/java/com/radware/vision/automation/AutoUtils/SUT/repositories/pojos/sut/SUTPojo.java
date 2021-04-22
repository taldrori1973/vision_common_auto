package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut;

import lombok.Data;

@Data
public class SUTPojo {
    private String serverName;
    private Pair pair;
    private String setupFile;
    private String environment;
    private ClientConfiguration clientConfiguration;
    private CliConfiguration cliConfiguration;
}
