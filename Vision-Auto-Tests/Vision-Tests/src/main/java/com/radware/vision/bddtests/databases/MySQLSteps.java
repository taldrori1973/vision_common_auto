package com.radware.vision.bddtests.databases;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.GenericCRUD;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.VisionDBSchema;
import com.radware.vision.base.WebUITestBase;
import cucumber.api.java.en.Then;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/10/2020
 * Time: 5:22 PM
 */
public class MySQLSteps extends WebUITestBase {
    @Then("^MYSQL Validate Single Value by SELECT \"([^\"]*)\" Column FROM \"([^\"]*)\" Schema and \"([^\"]*)\" Table WHERE \"([^\"]*)\" ([^\"]*) \"([^\"]*)\"$")
    public void mysqlValidateSingleValueBySELECTColumnFROMSchemaAndTableWHEREEQUALS(String columnName, VisionDBSchema schema, String tableName, String whereCondition, OperatorsEnum operation, String value) {
        try {
            if (columnName.isEmpty() || tableName.isEmpty())
                BaseTestUtils.report("Column Name or Table Name is Empty", Reporter.FAIL);

            String resultValue = GenericCRUD.selectSingleValue(schema, columnName, tableName, whereCondition).toString();

            if (!resultValue.equals(value))
                BaseTestUtils.report(
                        String.format("The value returned from database not equals to expected value:\n" +
                                "Actual Value:\"%s\"\n" +
                                "Expected Value:\"%s\"", resultValue, value), Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
