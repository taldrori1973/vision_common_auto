package com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers;

import systemobject.terminal.Prompt;


import java.util.ArrayList;

/**
 * @author Hadar Elbaz
 */

public class VisionRadwareFirstTime extends ServerCliBase {

    String netMask;
    String gateway;
    String primaryDns;
    String physicalManagement;
    String vmName;
    String ip;

    ServerCliBase vm;

    public VisionRadwareFirstTime(String user, String password, String netMask,
                                  String gateway,
                                  String primaryDns,
                                  String physicalManagement,
                                  String vmName,
                                  String ip) {
        super(ip, user, password);
        this.netMask = netMask;
        this.gateway = gateway;
        this.primaryDns = primaryDns;
        this.physicalManagement = physicalManagement;
        this.vmName = vmName;
        this.ip = ip;
        this.vm = this;

    }

    public VisionRadwareFirstTime(String user,
                                  String password,
                                  String hostIP,
                                  String netMask,
                                  String gateway,
                                  String primaryDns,
                                  String physicalManagement,
                                  String vmName,
                                  String ip) {
        super(hostIP, user, password);
        this.netMask = netMask;
        this.gateway = gateway;
        this.primaryDns = primaryDns;
        this.physicalManagement = physicalManagement;
        this.vmName = vmName;
        this.ip = ip;
        this.vm = this;

    }

//    @Override
//    public void init() throws Exception {
//        super.init();
//
//    }

//    public void close() {
//        super.close();
//    }


    @Override
    public Prompt[] getPrompts() {
        ArrayList<Prompt> prompts = new ArrayList<>();
        Prompt p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("$ ");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("# ");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("> ");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt(">");
        prompts.add(p);

        // For root commands - Deployment Phase End testing
        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("~]# ");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt(")#");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("qcow2 saved \\[.*/.*\\]");
        p.setRegularExpression(true);
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Ubuntu %s LTS %s ttyS0");
        p.setDontWaitForScrollEnd(true);
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Domain creation completed. You can restart your domain by running");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Escape character is ^]");
        p.setStringToSend("");
        p.setDontWaitForScrollEnd(true);
        p.setCommandEnd(false);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("login:");
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("vision login: ");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Password:");
        p.setStringToSend(getPassword());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("IP Address: ");
        p.setStringToSend(getIp());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Netmask/Prefix: ");
        p.setStringToSend(getNetMask());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Gateway: ");
        p.setStringToSend(getGateway());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Primary DNS Server: ");
        p.setStringToSend(getPrimaryDns());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Secondary DNS Server: ");
        p.setStringToSend("");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Docker Subnet \\(default is .*\\), ENTER to use it\\)");
        p.setRegularExpression(true);
        p.setStringToSend("10.10.0.0");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Docker Subnet \\(default is .*, ENTER to use it\\):");
        p.setRegularExpression(true);
        p.setStringToSend("10.10.0.0");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Physical Management Interface \\[G1 G2 G3\\]  \\(Active links on:.*\\): ");
        p.setRegularExpression(true);
        p.setStringToSend(getPhysicalManagement());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Physical Management Interface \\[G1 G2\\] \\(Active links on:.*\\): ");
        p.setRegularExpression(true);
        p.setStringToSend(getPhysicalManagement());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Physical Management Interface \\[G1 G2 G3\\] \\(Active links on:.*\\): ");
        p.setRegularExpression(true);
        p.setStringToSend(getPhysicalManagement());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Apply these settings [y/N]? ");
        p.setStringToSend("y");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Apply these settings? [y/N] ");
        p.setStringToSend("y");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Detected IP Addresses");
        p.setCommandEnd(true);
        p.setDontWaitForScrollEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Do you want to change the root user password? [y/N]");
        p.setStringToSend("n");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Do you want to disable ssh login for root user account (recommended)? [Y/n]");
        p.setStringToSend("n");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("[y/N]? ");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("(Y/N)");
        p.setCommandEnd(true);
        prompts.add(p);


        p = new Prompt();
        p.setPrompt("Continue? [yes/no]");
        p.setStringToSend("yes");
        prompts.add(p);


        p = new Prompt();
        p.setPrompt("vision.radware login: ");
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("vision.radware.localdomain login: ");
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("vision.radware.localdomain.localdomain.localdomain login: ");
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Password: ");
        p.setStringToSend(getVm().getPassword());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("ssh root login was not changed.");
        p.setDontWaitForScrollEnd(true);
        p.setCommandEnd(true);
        prompts.add(p);


        return prompts.toArray(new Prompt[prompts.size()]);
    }

    public String getNetMask() {
        return netMask;
    }

    public void setNetMask(String netMask) {
        this.netMask = netMask;
    }

    public String getGateway() {
        return gateway;
    }

    public void setGateway(String gateway) {
        this.gateway = gateway;
    }

    public String getPrimaryDns() {
        return primaryDns;
    }

    public void setPrimaryDns(String primaryDns) {
        this.primaryDns = primaryDns;
    }

    public String getPhysicalManagement() {
        return physicalManagement;
    }

    public String getVmName() {
        return vmName;
    }


    public void setPhysicalManagement(String physicalManagement) {
        this.physicalManagement = physicalManagement;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public void setVmName(String vmName) {
        this.vmName = vmName;
    }


    public ServerCliBase getVm() {
        if (vm == null)
            vm = new ServerCliBase(getIp(), "radware", "radware");

        return vm;
    }

    public void setTerminalAndCliEqualNull() {
        terminal = null;
        cli = null;
    }

    public void changeCommandToSendForPrompt(String promptString, String promptCommand) {
        Prompt p = new Prompt();
        p.setPrompt(promptString);
        for (Prompt prompt : terminal.getPrompts()) {
            if (prompt.equals(p)) {
                prompt.setStringToSend(promptCommand);
                return;
            }
        }
        p.setStringToSend(promptCommand);
        terminal.addPrompt(p);
    }

    /*public Prompt promptStringFormat(String promptString, Object... args) {
        Prompt p = new Prompt();
        p.setPrompt(String.format(promptString, args));
        for (Prompt prompt : terminal.getPrompts())
        {
            if (prompt.getPrompt().equals(promptString))
            {
                p.setStringToSend(prompt.getStringToSend());
                p.setCommandEnd(prompt.isCommandEnd());
                p.setRegularExpression(prompt.isRegularExpression());
                break;
            }
        }
        terminal.addPrompt(p);
        return p;
    }*/
}