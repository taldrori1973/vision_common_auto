package com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers;

import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.bddtests.basicoperations.BasicOperationsSteps;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.bddtests.ReportsForensicsAlerts.WebUiTools;
import com.radware.vision.infra.utils.TimeUtils;
import org.json.JSONObject;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;



public class SelectScheduleHandlers {

    public static void selectScheduling(String runEvery, JSONObject scheduleJson, Map<String, LocalDateTime> schedulingDates, String name) throws Exception {
        Schedule schedule = getSchedule(runEvery, scheduleJson);
        schedule.create();
        if (schedule.isWithComputing())
            schedulingDates.put(name, schedule.scheduleTime);
    }

    public static void validateScheduling(String runEvery, JSONObject actualSchedulingJson, JSONObject expectedScheduleJson,  StringBuilder errorMessage, Map<String, LocalDateTime> schedulingDates, String name){
        getSchedule(runEvery, expectedScheduleJson).validate(actualSchedulingJson , errorMessage, schedulingDates, name);
    }

    private static Schedule getSchedule(String runEvery, JSONObject scheduleJson) {
        Schedule schedule;
        switch (runEvery.toLowerCase()) {
            case "weekly":
                schedule = new ScheduleWeekly(scheduleJson);
                break;
            case "monthly":
                schedule = new ScheduleMonthly(scheduleJson);
                break;
            case "once":
                schedule = new ScheduleOnce(scheduleJson);
                break;
            case "daily":
            default:
                schedule = new ScheduleDaily(scheduleJson);
                break;
        }
        return schedule;
    }

    private static abstract class Schedule {
        final String dailyTimePattern = "hh:mm a";
        final String onceTimePattern = "yyyy-MM-dd HH:mm";
        JSONObject expectedScheduleJson = new JSONObject();
        JSONObject actualScheduleJson = new JSONObject();
        final String actualTimeKey = "time";
        LocalDateTime scheduleTime;

        abstract public void create() throws Exception;
        abstract public void validate(JSONObject actualScheduleJson, StringBuilder errorMessage, Map<String, LocalDateTime> schedulingDates, String name);
        protected String getPattern(){return dailyTimePattern;}

        protected void saveScheduleTime(String pattern)
        {
            if (isWithComputing())
                scheduleTime = getScheduleComputingTime();
            else
                scheduleTime = getNonComputingTime(pattern);
        }

        protected LocalDateTime getNonComputingTime(String pattern) {
            return LocalDateTime.parse(expectedScheduleJson.get("On Time").toString().trim() + "01.01.20", DateTimeFormatter.ofPattern(pattern + "dd.MM.yy"));
        }

        protected String getActualTime() {return actualScheduleJson.get(actualTimeKey).toString();}

        protected String getExpectedValidateTime(Map<String, LocalDateTime> schedulingDates, String name) {
            if (isWithComputing())//Todo suit error message if the schedule isn't exist - MAHA
                return DateTimeFormatter.ofPattern("HH:mm").format(schedulingDates.get(name));
            else return LocalTime.parse(expectedScheduleJson.get("On Time").toString(), DateTimeFormatter.ofPattern(dailyTimePattern)).format(DateTimeFormatter.ofPattern("HH:mm"));
        }

        final boolean isWithComputing()
        {return TimeUtils.isWithComputing(expectedScheduleJson.get("On Time").toString());}

        LocalDateTime getScheduleComputingTime() {return TimeUtils.getAddedDate(expectedScheduleJson.get("On Time").toString().trim());}

        String getScheduleTimeAsText(String pattern) {
            if (isWithComputing())
                return TimeUtils.getTimeAsText(scheduleTime, pattern);
            else
                return LocalTime.parse(expectedScheduleJson.get("On Time").toString().trim(),DateTimeFormatter.ofPattern(getPattern())).format(DateTimeFormatter.ofPattern(pattern));
        }

        void validateTime(JSONObject actualScheduleJson, StringBuilder errorMessage, Map<String, LocalDateTime> schedulingDates, String name) {
            this.actualScheduleJson = actualScheduleJson;
            String actualOnTime = getActualTime();
            String expectedTime = getExpectedValidateTime(schedulingDates, name);
            if (!actualOnTime.equalsIgnoreCase(expectedTime))
                errorMessage.append("the Actual on Time is ").append(actualOnTime).append(" but the Expected is ").append(expectedTime).append("\n");
        }

        protected void setTimeInput()
        {
            String [] timePartsArray = {getScheduleTimeAsText("hh"), getScheduleTimeAsText("mm"), getScheduleTimeAsText("a")};
            for (int i=1; i<=3; i++)
            {
                WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//*[@class='ant-time-picker-input']").getBy()).click();
                WebElement timeElement = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//div[contains(@class,'ant-time-picker-panel-select')][" + i + "]//li[.='"+ timePartsArray[i-1] + "']").getBy(), 25000);
                WebUIUtils.scrollIntoView(timeElement, true);
                WebUIUtils.sleep(2);
                ((JavascriptExecutor) WebUIUtils.getDriver()).executeScript("arguments[0].click();", timeElement);
                WebUiTools.getWebElement("apply Time Button").click();
            }
        }

        protected void selectDaysOrMonths(String buttonLabel,  List<Object> buttonElements) throws Exception {
            if (buttonElements.size()>0)
            {
                WebUiTools.checkElements(buttonLabel, "", false);
                String remainElementParam = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//*[contains(@data-debug-id,'" + VisionDebugIdsManager.getDataDebugId() + "')and@" + WebUiTools.checkedNotCheckedAttribute + "='true']").getBy()).getText();
                WebUiTools.check(buttonLabel,buttonElements, true);
                WebUiTools.check(buttonLabel, remainElementParam, buttonElements.contains(remainElementParam));
            }
        }
    }

    private static class ScheduleDaily extends Schedule{
        ScheduleDaily(JSONObject scheduleJson){
            this.expectedScheduleJson = scheduleJson;
            saveScheduleTime(dailyTimePattern);
        }

        @Override
        public void create() {
            setTimeInput();
        }

        @Override
        public void validate(JSONObject actualScheduleJson, StringBuilder errorMessage, Map<String, LocalDateTime> schedulingDates, String name)
        {
            validateTime(actualScheduleJson,errorMessage, schedulingDates, name);
        }
    }

    private static class ScheduleOnce extends Schedule{
        ScheduleOnce(JSONObject scheduleJson)
        {
            this.expectedScheduleJson = scheduleJson;
            saveScheduleTime(onceTimePattern);
        }
        protected String getPattern(){return onceTimePattern;}

        protected String getExpectedValidateTime(Map<String, LocalDateTime> schedulingDates, String name)
        {
            if (isWithComputing())
                return DateTimeFormatter.ofPattern(onceTimePattern).format(schedulingDates.get(name));
            else return expectedScheduleJson.get("On date").toString();
        }

        protected String getActualTime()
        {
            return actualScheduleJson.get("date").toString() + " " + super.getActualTime();
        }

        protected LocalDateTime getNonComputingTime(String pattern) {
            return LocalDateTime.parse(expectedScheduleJson.get("On Time").toString().trim(), DateTimeFormatter.ofPattern(pattern));
        }
        @Override
        public void create() throws TargetWebElementNotFoundException {
            BasicOperationsSteps.fillTime("Schedule Once Time", "", scheduleTime);
        }

        @Override
        public void validate(JSONObject actualScheduleJson, StringBuilder errorMessage, Map<String, LocalDateTime> schedulingDates, String name)
        {
            validateTime(actualScheduleJson,errorMessage, schedulingDates, name);
        }
    }

    private static class ScheduleMonthly extends Schedule{
        private String dayOfMonth;
        List<Object> months;

        ScheduleMonthly(JSONObject scheduleJson) {
            this.expectedScheduleJson = scheduleJson;
            dayOfMonth = scheduleJson.has("ON Day of Month")?
                    scheduleJson.getString("ON Day of Month"):
                    isWithComputing()?
                            String.valueOf(getScheduleComputingTime().getDayOfMonth()):
                            "-1";
            months = scheduleJson.has("At Months")?
                    scheduleJson.getJSONArray("At Months").toList():
                    isWithComputing()?
                            new ArrayList<>(Collections.singletonList(TimeUtils.getTimeAsText(getScheduleComputingTime(), "MMM").toUpperCase())):
                            new ArrayList<>();
            saveScheduleTime(dailyTimePattern);
        }

        @Override
        public void create() throws Exception {
            setTimeInput();
            if (!dayOfMonth.equals("-1")) {
                setTextDayOfMonth();
                if (!WebUiTools.getWebElement("Scheduling On Day of Month").getAttribute("value").equals(dayOfMonth))
                {
                    WebUIUtils.sleep(1);
                    setTextDayOfMonth();
                }
            }
            selectDaysOrMonths("Schedule Month", months);
        }

        protected void setTextDayOfMonth() throws TargetWebElementNotFoundException {
            WebUiTools.getWebElement("Scheduling On Day of Month").clear();
            BasicOperationsHandler.setTextField("Scheduling On Day of Month", dayOfMonth, true);
        }

        @Override
        public void validate(JSONObject actualScheduleJson, StringBuilder errorMessage, Map<String, LocalDateTime> schedulingDates, String name)
        {
            validateTime(actualScheduleJson, errorMessage, schedulingDates, name);
            validateDayOfMonth(actualScheduleJson, errorMessage);
            validateMonths(actualScheduleJson, errorMessage);
        }

        private void validateMonths(JSONObject actualScheduleJson, StringBuilder errorMessage) {
            List actualMonths = actualScheduleJson.getJSONArray("months").toList();
            List expectedMonths = months.size()==0? Collections.singletonList("January"):months;
            List monthsOfYear = Arrays.asList("january", "february", "march", "april","may", "june", "july", "august", "september", "october", "november", "december");
            for (Object month : monthsOfYear) {
                if (actualMonths.contains(month) && !expectedMonths.contains(((String) month).substring(0,3).toUpperCase()))
                    errorMessage.append("The month ").append(((String) month).substring(0, 3).toUpperCase()).append(" is exist in actual Months but it isn't exist in the expected Months").append("\n");
                if (!actualMonths.contains(month) && expectedMonths.contains(((String) month).substring(0,3).toUpperCase()))
                    errorMessage.append("The month ").append(((String) month).substring(0, 3).toUpperCase()).append(" is exist in expected Months but it isn't exist in the actual Months").append("\n");
            }
        }

        private void validateDayOfMonth(JSONObject actualScheduleJson, StringBuilder errorMessage) {
            String actualDayOfMonth = actualScheduleJson.get("dayOfMonth").toString();
            String expectedDayOfMonth = !dayOfMonth.equalsIgnoreCase("-1")?dayOfMonth:"1";
            if (!actualDayOfMonth.equalsIgnoreCase(expectedDayOfMonth))
                errorMessage.append("the Actual day of expectedMonth is " + actualDayOfMonth + " but the expected is " + expectedDayOfMonth).append("\n");
        }
    }
    private static class ScheduleWeekly extends Schedule{
        List<Object> days;

        ScheduleWeekly(JSONObject scheduleJson)
        {
            this.expectedScheduleJson = scheduleJson;
            days = scheduleJson.has("At Days")?
                    scheduleJson.getJSONArray("At Days").toList():
                    isWithComputing()?
                            new ArrayList<>(Collections.singletonList(TimeUtils.getTimeAsText(getScheduleComputingTime(), "EEE").toUpperCase())):
                            new ArrayList<>();
            saveScheduleTime(dailyTimePattern);
        }

        @Override
        public void create() throws Exception {
            setTimeInput();
            selectDaysOrMonths("Schedule Day", days);
        }

        @Override
        public void validate(JSONObject actualScheduleJson, StringBuilder errorMessage, Map<String, LocalDateTime> schedulingDates, String name)
        {
            validateTime(actualScheduleJson, errorMessage, schedulingDates, name);
            validateDaysOfWeek(actualScheduleJson, errorMessage);

        }

        private void validateDaysOfWeek(JSONObject actualScheduleJson, StringBuilder errorMessage)
        {
            List actualDays = actualScheduleJson.getJSONArray("daysOfWeek").toList();
            List expectedDays = days.size()==0? Collections.singletonList("MON"):days;
            List daysOfWeek = Arrays.asList("sunday", "monday", "tuesday", "wednesday","thursday", "friday", "saturday");
            for (Object day : daysOfWeek) {
                if (actualDays.contains(day) && !expectedDays.contains(day.toString().toUpperCase().substring(0,3)))
                    errorMessage.append("The day ").append(day).append(" is exist in actual days but it isn't exist in the expected days").append("\n");
                if (!actualDays.contains(day) && expectedDays.contains(day.toString().toUpperCase().substring(0,3)))
                    errorMessage.append("The day ").append(day).append(" is exist in expected days but it isn't exist in the actual days").append("\n");
            }
        }
    }
}
