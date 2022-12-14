package com.radware.vision.bddtests.vmoperations.Deploy;
import com.radware.vision.automation.Deploy.NewVmHandler;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;

import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.getVisionSetupAttributeFromSUT;

public class FreshInstallKVM extends Deploy {
    private boolean isAPM;

    public FreshInstallKVM() {
        super(TestBase.restTestBase.getVisionRestClient().getDeviceIp(), FileType.QCOW2);
        initIsAPM();
        buildFileInfo(FileType.QCOW2);
    }

    public void initIsAPM() {
        String attr = getVisionSetupAttributeFromSUT("serverType");
        this.isAPM = attr != null && "apm".equals(attr.toLowerCase().trim());
    }


    @Override
    public void deploy() {
        NewVmHandler vmHandler = new NewVmHandler();
        try {
            vmHandler.firstTimeWizardKVM(isAPM, version, build, buildFileInfo.getDownloadUri().toString() , buildFileInfo.getChecksums().getMd5());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}