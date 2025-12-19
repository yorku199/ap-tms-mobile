-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2025 at 07:24 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tms`
--

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) NOT NULL,
  `email_address` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hibernate_sequence`
--

CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `qrtz_blob_triggers`
--

CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='qrtz_blob_triggers\r\nqrtz_BLOB_TRIGGERS';

-- --------------------------------------------------------

--
-- Table structure for table `qrtz_calendars`
--

CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `qrtz_cron_triggers`
--

CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='qrtz_cron_triggers\r\nqrtz_CRON_TRIGGERS';

-- --------------------------------------------------------

--
-- Table structure for table `qrtz_fired_triggers`
--

CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `qrtz_job_details`
--

CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `qrtz_locks`
--

CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `qrtz_scheduler_state`
--

CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='qrtz_scheduler_state\r\nqrtz_SCHEDULER_STATE';

-- --------------------------------------------------------

--
-- Table structure for table `qrtz_simple_triggers`
--

CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='qrtz_simple_triggers\r\nqrtz_SIMPLE_TRIGGERS';

-- --------------------------------------------------------

--
-- Table structure for table `qrtz_simprop_triggers`
--

CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='qrtz_simprop_triggers\r\nqrtz_SIMPROP_TRIGGERS';

-- --------------------------------------------------------

--
-- Table structure for table `qrtz_triggers`
--

CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='qrtz_triggers\r\nqrtz_TRIGGERS';

-- --------------------------------------------------------

--
-- Table structure for table `tb_accident_area_type`
--

CREATE TABLE `tb_accident_area_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_accident_type`
--

CREATE TABLE `tb_accident_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_advance_payment_master`
--

CREATE TABLE `tb_advance_payment_master` (
  `advance_payment_id` bigint(20) NOT NULL COMMENT 'PK',
  `advance_payment_code` varchar(100) DEFAULT NULL COMMENT 'เลขที่ RQ',
  `project_id` bigint(20) DEFAULT NULL COMMENT 'Project(FK From tb_project)',
  `total_amount` double(22,0) DEFAULT NULL COMMENT 'เงินตั้งต้น',
  `outstanding_amount` double(22,0) DEFAULT NULL COMMENT 'เงินคงเหลือ',
  `account_group` varchar(100) DEFAULT NULL COMMENT 'รหัสบัญชี',
  `status` varchar(100) DEFAULT NULL COMMENT 'สถานะการใช้งาน',
  `create_date` datetime DEFAULT NULL COMMENT 'Created date',
  `create_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `update_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `update_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `cycle_date` datetime DEFAULT NULL COMMENT 'รอบ RQ',
  `edition_no` varchar(255) DEFAULT NULL COMMENT 'เลขครั้งที่ RQ',
  `pay_amount` double(22,0) DEFAULT NULL COMMENT 'เงินที่ใช้ไป',
  `pay_back_date` datetime DEFAULT NULL COMMENT 'วันที่คืนเงินทดรองจ่าย',
  `pay_date` datetime DEFAULT NULL COMMENT 'วันที่ต้องการใช้เงินทดรองจ่าย',
  `payment_status` varchar(255) DEFAULT NULL COMMENT 'สถานะของRQ',
  `received_by_id` bigint(20) DEFAULT NULL COMMENT 'FK From tb_user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_allowance_master`
--

CREATE TABLE `tb_allowance_master` (
  `allowance_no` varchar(50) NOT NULL COMMENT 'PK',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `allowance_status` char(1) DEFAULT NULL COMMENT 'สถานะของAllowance',
  `issue_date` datetime DEFAULT NULL COMMENT 'วันที่ออก allowance',
  `status` int(11) NOT NULL COMMENT 'สถานะการใช้งาน',
  `total_amt` decimal(19,2) DEFAULT NULL COMMENT 'จำนวนเงินรวม',
  `total_pay_driver_amt` decimal(19,2) DEFAULT NULL COMMENT 'ค่าเที่ยวพนักงานขับรถ',
  `total_pay_driver_overtime_amt` decimal(19,2) DEFAULT NULL COMMENT 'ค่าล่วงเวลาพนักงานขับรถ',
  `total_pay_driver_receive_amt` decimal(19,2) DEFAULT NULL COMMENT 'ค่าเที่ยวพนักงานขับรถ(เที่ยวรับ)',
  `total_pay_driver_send_amt` decimal(19,2) DEFAULT NULL COMMENT 'ค่าเที่ยวพนักงานขับรถ(เที่ยวส่ง)',
  `total_pay_porter_amt` decimal(19,2) DEFAULT NULL COMMENT 'ค่าแรงพนักงานลงสินค้า(เด็กรถ)',
  `total_pay_tow_point_amt` decimal(19,2) DEFAULT NULL COMMENT 'ค่าพ่วงจุด',
  `driver_id` bigint(20) DEFAULT NULL COMMENT 'คนขับรถ(FK FROM tb_user)',
  `job_type_id` bigint(20) DEFAULT NULL COMMENT 'JobType(FK FROM tb_job_type)',
  `project_id` bigint(20) DEFAULT NULL COMMENT 'Project(FK FROM tb_project)',
  `truck_tractor_id` bigint(20) DEFAULT NULL COMMENT 'รถบรรทุก(FK FROM tb_truck_profile)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_allowance_sub_master`
--

CREATE TABLE `tb_allowance_sub_master` (
  `allowance_sub_no` varchar(50) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `allowance_sub_status` char(1) DEFAULT NULL,
  `issue_date` datetime DEFAULT NULL,
  `pay_driver_sub_amt` decimal(19,2) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `truck_number_description` varchar(300) DEFAULT NULL,
  `job_type_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_bank`
--

CREATE TABLE `tb_bank` (
  `code` varchar(255) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_carrier`
--

CREATE TABLE `tb_carrier` (
  `carrierID` int(11) NOT NULL,
  `carrierCode` varchar(20) NOT NULL,
  `loadDate` datetime NOT NULL,
  `completedFlag` varchar(5) DEFAULT '',
  `errorMessage` text DEFAULT NULL,
  `lastUpdateDate` datetime DEFAULT NULL,
  `lastUpdateUser` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_city`
--

CREATE TABLE `tb_city` (
  `cityID` int(11) NOT NULL,
  `cityNameEn` varchar(50) DEFAULT NULL,
  `cityNameTh` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tb_container_size`
--

CREATE TABLE `tb_container_size` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_credit_term`
--

CREATE TABLE `tb_credit_term` (
  `CREDIT_TERM_ID` int(11) NOT NULL COMMENT 'PK',
  `CREDIT_TERM_NAME` varchar(100) DEFAULT NULL COMMENT 'เงื่อนไขการชำระเงิน',
  `CREDIT_TERM_STATUS` tinyint(3) DEFAULT NULL COMMENT 'สถานะการใช้งาน',
  `credit_term_date_amount` int(11) DEFAULT NULL COMMENT 'จำนวนวัน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='เงื่อนไขการชำระเงิน';

-- --------------------------------------------------------

--
-- Table structure for table `tb_customer`
--

CREATE TABLE `tb_customer` (
  `id` bigint(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `license_number` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `project` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_date` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_customer_attachment`
--

CREATE TABLE `tb_customer_attachment` (
  `attachment_no` varchar(30) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `attachment_name` varchar(255) DEFAULT NULL,
  `attachment_remark` text DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `thumbnail` text DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `customer_attachment_type_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_customer_group`
--

CREATE TABLE `tb_customer_group` (
  `customer_group_id` bigint(20) NOT NULL,
  `customer_group_name` varchar(255) DEFAULT NULL,
  `customer_group_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_cust_job_type`
--

CREATE TABLE `tb_cust_job_type` (
  `cust_user_id` bigint(20) NOT NULL,
  `job_type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_cust_project`
--

CREATE TABLE `tb_cust_project` (
  `cust_user_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_department`
--

CREATE TABLE `tb_department` (
  `departmentId` int(11) NOT NULL,
  `department_n` varchar(25) DEFAULT NULL,
  `department_c` varchar(25) DEFAULT NULL,
  `status` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tb_driver_leave`
--

CREATE TABLE `tb_driver_leave` (
  `id` bigint(20) NOT NULL,
  `driver_id` bigint(20) NOT NULL,
  `leave_date` date NOT NULL,
  `leave_type` varchar(50) NOT NULL,
  `remark` varchar(1000) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_education`
--

CREATE TABLE `tb_education` (
  `code` varchar(255) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_emp_company`
--

CREATE TABLE `tb_emp_company` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_emp_department`
--

CREATE TABLE `tb_emp_department` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_emp_position`
--

CREATE TABLE `tb_emp_position` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_emp_section`
--

CREATE TABLE `tb_emp_section` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_emp_type`
--

CREATE TABLE `tb_emp_type` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_expense_detail`
--

CREATE TABLE `tb_expense_detail` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `expense_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_expense_master`
--

CREATE TABLE `tb_expense_master` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_fault_accident_type`
--

CREATE TABLE `tb_fault_accident_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_fleet_card`
--

CREATE TABLE `tb_fleet_card` (
  `FLEETCARD_ID` int(11) NOT NULL,
  `FLEETCARD_BRAND` varchar(50) DEFAULT NULL,
  `FLEETCARD_NO` varchar(50) DEFAULT NULL,
  `FLEETCARD_CREDIT_LIMIT` varchar(20) DEFAULT NULL,
  `FLEETCARD_RECIEVE_DATE` varchar(100) DEFAULT NULL,
  `FLEET_EXPIRY_DATE` varchar(100) DEFAULT NULL,
  `FLEET_CARD_STATUS` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_fuel_input`
--

CREATE TABLE `tb_fuel_input` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `date_fill` datetime DEFAULT NULL,
  `description_fill` text DEFAULT NULL,
  `inv_no` varchar(255) DEFAULT NULL,
  `liter` double DEFAULT NULL,
  `liter_rate` double DEFAULT NULL,
  `mileage` double DEFAULT NULL,
  `mileage_amount` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `driver_id` bigint(20) DEFAULT NULL,
  `gas_station_id` bigint(20) DEFAULT NULL,
  `truck_tractor_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_gasoline_dynamic_master`
--

CREATE TABLE `tb_gasoline_dynamic_master` (
  `gasoline_id` varchar(100) NOT NULL,
  `customer_no` varchar(100) DEFAULT NULL,
  `seq` varchar(100) DEFAULT NULL,
  `start_from_ditit1` int(11) DEFAULT NULL,
  `start_from_digit2` int(11) DEFAULT NULL,
  `end_digit1` int(11) DEFAULT NULL,
  `end_digit2` int(11) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `create_by` varchar(100) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_by` varchar(100) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_gas_station`
--

CREATE TABLE `tb_gas_station` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_goods_receipt_note`
--

CREATE TABLE `tb_goods_receipt_note` (
  `id` bigint(20) NOT NULL,
  `grn_no` varchar(50) NOT NULL,
  `grn_date` date DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `receiver_id` bigint(20) DEFAULT NULL,
  `receiver_name` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `vendor_name` varchar(200) DEFAULT NULL,
  `vendor_address` text DEFAULT NULL,
  `vendor_phone` varchar(50) DEFAULT NULL,
  `vendor_email` varchar(100) DEFAULT NULL,
  `delivery_note_no` varchar(100) DEFAULT NULL,
  `invoice_no` varchar(100) DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `purchase_order_id` bigint(20) DEFAULT NULL,
  `purchase_order_ids` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `sub_total` decimal(15,2) DEFAULT NULL,
  `withholding_tax_rate` decimal(5,2) DEFAULT NULL,
  `withholding_tax_amount` decimal(15,2) DEFAULT NULL,
  `net_total` decimal(15,2) DEFAULT NULL,
  `approved_by` bigint(20) DEFAULT NULL,
  `approved_date` datetime DEFAULT NULL,
  `rejected_by` bigint(20) DEFAULT NULL,
  `rejected_date` datetime DEFAULT NULL,
  `reject_reason` text DEFAULT NULL,
  `receiver_sign_date` datetime DEFAULT NULL,
  `approver_sign_date` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `checker_sign_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_goods_receipt_note_item`
--

CREATE TABLE `tb_goods_receipt_note_item` (
  `id` bigint(20) NOT NULL,
  `goods_receipt_note_id` bigint(20) NOT NULL,
  `line_no` int(11) DEFAULT NULL,
  `item_code` varchar(100) DEFAULT NULL,
  `item_description` text DEFAULT NULL,
  `ordered_quantity` decimal(15,4) DEFAULT NULL,
  `received_quantity` decimal(15,4) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `unit_price` decimal(15,4) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `purchase_order_id` bigint(20) DEFAULT NULL,
  `purchase_order_item_id` bigint(20) DEFAULT NULL,
  `po_no` varchar(50) DEFAULT NULL,
  `batch_no` varchar(100) DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `sps_id` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `remarks` text DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `po_item_id` bigint(20) DEFAULT NULL,
  `is_bonus_item` tinyint(1) DEFAULT 0 COMMENT 'Indicates if this is a bonus item with 0 value'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_goods_receipt_note_sub_item`
--

CREATE TABLE `tb_goods_receipt_note_sub_item` (
  `id` bigint(20) NOT NULL,
  `goods_receipt_note_item_id` bigint(20) NOT NULL,
  `line_no` int(11) DEFAULT NULL,
  `sps_id` int(20) DEFAULT NULL,
  `item_code` varchar(100) DEFAULT NULL,
  `sub_item_code` varchar(100) DEFAULT NULL,
  `sub_item_name` varchar(150) NOT NULL,
  `sub_item_description` text DEFAULT NULL,
  `sub_item_serial_no` varchar(100) DEFAULT NULL,
  `sub_item_model` varchar(100) DEFAULT NULL,
  `sub_item_brand` varchar(100) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT 1.0000,
  `unit` varchar(50) DEFAULT NULL,
  `unit_price` decimal(15,4) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `condition_status` varchar(50) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_gps_type`
--

CREATE TABLE `tb_gps_type` (
  `Id` int(11) NOT NULL,
  `GPSTYPE` text DEFAULT NULL,
  `GPS_STATUS` tinyint(1) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `CREATE_BY` varchar(100) DEFAULT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `UPDATE_BY` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_gsdb_code`
--

CREATE TABLE `tb_gsdb_code` (
  `Id` bigint(20) NOT NULL COMMENT 'PK',
  `GSDB_CODE` mediumtext DEFAULT NULL COMMENT 'Code',
  `GSDB_NAME` mediumtext DEFAULT NULL COMMENT 'Name',
  `Latitude` decimal(10,6) DEFAULT NULL COMMENT 'Latitude',
  `Longitude` decimal(10,6) DEFAULT NULL COMMENT 'Longitude',
  `RADIUS` decimal(10,2) DEFAULT NULL COMMENT 'Radius',
  `DELIVERY_TYPE` int(11) DEFAULT NULL COMMENT '-',
  `STATUS` tinyint(1) DEFAULT NULL COMMENT 'สถานะการใช้งาน',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT 'Created date',
  `CREATE_BY` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT 'Updated date',
  `UPDATE_BY` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `GSDB_PROVINCE_ID` bigint(20) DEFAULT NULL COMMENT 'จังหวัด(FK FROM tb_province)',
  `GSDB_AREA_ZONE` mediumtext DEFAULT NULL COMMENT 'Area zone'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Station';

-- --------------------------------------------------------

--
-- Table structure for table `tb_gsdb_delivery_type`
--

CREATE TABLE `tb_gsdb_delivery_type` (
  `Id` int(11) NOT NULL,
  `DELIVERY_TYPE` varchar(100) DEFAULT NULL,
  `DELIVERY_REMARK` varchar(100) DEFAULT NULL,
  `STATUS` tinyint(1) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `CREATE_BY` varchar(100) DEFAULT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `UPDATE_BY` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_history_tire`
--

CREATE TABLE `tb_history_tire` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `position_no` int(11) NOT NULL,
  `stamp_date` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `maintenance_tire_id` bigint(20) DEFAULT NULL,
  `truck_profile_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_income_type`
--

CREATE TABLE `tb_income_type` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `status` int(11) DEFAULT NULL COMMENT 'Status'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_insurance_act`
--

CREATE TABLE `tb_insurance_act` (
  `ACT_ID` int(11) NOT NULL,
  `ACT_NO` varchar(30) DEFAULT NULL,
  `ACT_EXPIRE_DATE` varchar(30) DEFAULT NULL,
  `ACT_INSURANCE_MOTOR` varchar(150) DEFAULT NULL,
  `ACT_INSURANCE_LIMIT` double DEFAULT NULL,
  `ACT_RESPONSE_BY` bigint(20) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `ACT_INSURANCE_LIMIT_ORG` varchar(20) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `act_premium` double DEFAULT NULL,
  `act_insurance_phone_number` varchar(255) DEFAULT NULL,
  `truck_id` bigint(20) DEFAULT NULL,
  `act_insurance_company` bigint(20) DEFAULT NULL,
  `act_insurance_expire_date` datetime DEFAULT NULL,
  `act_insurance_start_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_insurance_company`
--

CREATE TABLE `tb_insurance_company` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_insurance_cover_product`
--

CREATE TABLE `tb_insurance_cover_product` (
  `POLICY_ID` int(11) NOT NULL,
  `INSURANCE_LIMIT` double DEFAULT NULL,
  `POLICY_EXPIRE_DATE` varchar(30) DEFAULT NULL,
  `INSURANCE_COVER_PRODUCT` varchar(150) DEFAULT NULL,
  `INSURANCE_RESPONSE_BY` bigint(20) DEFAULT NULL,
  `POLICY_NO` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `INSURANCE_LIMIT_ORG` varchar(20) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `insurance_premium` double DEFAULT NULL,
  `insurance_type` varchar(255) DEFAULT NULL COMMENT 'M=ins,C=cover product',
  `insurance_phone_number` varchar(255) DEFAULT NULL,
  `truck_id` bigint(20) DEFAULT NULL,
  `insurance_company` bigint(20) DEFAULT NULL,
  `insurance_expire_date` datetime DEFAULT NULL,
  `insurance_start_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_invoice_cover_master`
--

CREATE TABLE `tb_invoice_cover_master` (
  `invoice_cover_no` varchar(50) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `invoice_cover_gen_date` datetime DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `ref_no` varchar(50) DEFAULT NULL,
  `vender_code` varchar(50) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `net_pay_income_amt` decimal(19,2) DEFAULT NULL,
  `net_pay_payment_amt` decimal(19,2) DEFAULT NULL,
  `total_income_amt` decimal(19,2) DEFAULT NULL,
  `total_payment_amt` decimal(19,2) DEFAULT NULL,
  `withholding_tax_income_amt` decimal(19,2) DEFAULT NULL,
  `withholding_tax_payment_amt` decimal(19,2) DEFAULT NULL,
  `total_job_cost_amt` decimal(19,2) DEFAULT NULL,
  `total_payments_net` decimal(19,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_invoice_excel_group`
--

CREATE TABLE `tb_invoice_excel_group` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_invoice_excel_mapping`
--

CREATE TABLE `tb_invoice_excel_mapping` (
  `id` bigint(20) NOT NULL,
  `generate_type` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `job_type_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `invoice_excel_group_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_invoice_item`
--

CREATE TABLE `tb_invoice_item` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `period` int(11) DEFAULT NULL COMMENT 'งวด',
  `product_code` varchar(50) DEFAULT NULL COMMENT 'รหัส',
  `product_desc` varchar(300) DEFAULT NULL COMMENT 'รายละเอียด',
  `total_amt` decimal(19,2) DEFAULT NULL COMMENT 'จำนวนเงินใบ Invoice',
  `total_qty_amt` decimal(19,2) DEFAULT NULL COMMENT 'จำนวน Job',
  `invoice_id` varchar(50) NOT NULL COMMENT 'InvoiceMaster(FK From tb_invoice_master)',
  `bill_no` varchar(50) DEFAULT NULL COMMENT 'เลขที่บิล',
  `total_jobcost_amt` decimal(19,2) DEFAULT NULL COMMENT 'จำนวนเงินใบ IA',
  `receipt_ra_no` varchar(255) DEFAULT NULL COMMENT 'เลขที่ใบ RA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_invoice_master`
--

CREATE TABLE `tb_invoice_master` (
  `invoice_no` varchar(50) NOT NULL COMMENT 'PK',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `description` mediumtext DEFAULT NULL COMMENT 'Description',
  `due_date` datetime DEFAULT NULL COMMENT 'Due date',
  `invoice_cover_no` varchar(50) DEFAULT NULL COMMENT 'เลขที่ใบ invoice cover',
  `issue_date` datetime DEFAULT NULL COMMENT 'วันที่ใบ invoice',
  `net_pay_amt` decimal(19,2) DEFAULT NULL COMMENT 'จํานวนเงินสุทธิ',
  `period` varchar(255) DEFAULT NULL COMMENT 'งวด',
  `ref_no` varchar(50) DEFAULT NULL COMMENT 'Reference No',
  `site_id` varchar(50) DEFAULT NULL COMMENT 'Site id',
  `status` int(11) NOT NULL COMMENT 'สถานะการใช้งาน',
  `subject` varchar(255) DEFAULT NULL COMMENT 'Subject',
  `total_amt` decimal(19,2) DEFAULT NULL COMMENT 'จำนวนเงิน',
  `vender_code` varchar(50) DEFAULT NULL COMMENT 'Vender code',
  `withholding_tax_amt` decimal(19,2) DEFAULT NULL COMMENT 'จำนวนเงินภาษี ณ ที่จ่าย',
  `job_type_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_type',
  `project_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_project',
  `customer_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_stake_holder_master',
  `credit_term` varchar(300) DEFAULT NULL COMMENT 'Credit term',
  `invoice_status` char(1) DEFAULT NULL COMMENT 'สถานะของInvoice',
  `net_pay_jrp_amt` decimal(19,2) DEFAULT NULL COMMENT 'จํานวนเงินสุทธิ (tb_job_reserve_payment)',
  `total_jrp_amt` decimal(19,2) DEFAULT NULL COMMENT 'เปอร์เซ็นภาษี ณ ที่จ่าย (tb_job_reserve_payment)',
  `withholding_tax_jrp_amt` decimal(19,2) DEFAULT NULL COMMENT 'เปอร์เซ็นภาษี ณ ที่จ่าย (tb_job_reserve_payment)',
  `withholding_tax` int(11) NOT NULL COMMENT 'เปอร์เซ็นภาษี ณ ที่จ่าย',
  `total_qty_amt` decimal(19,2) DEFAULT NULL COMMENT 'จำนวน Job',
  `credit_term_date_value` int(11) NOT NULL COMMENT 'จำนวนวัน Credit term',
  `receipt_no` varchar(255) DEFAULT NULL COMMENT 'เลขที่ใบ Receipt',
  `amt_discount` decimal(19,2) DEFAULT NULL,
  `sr_no` varchar(255) DEFAULT NULL,
  `total_amt_income` decimal(19,2) DEFAULT NULL,
  `remark` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_cost`
--

CREATE TABLE `tb_job_cost` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_master',
  `route_truck_cost_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_route_truck_cost.',
  `truck_cost_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_cost_master.',
  `truck_cost_detail_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_cost_detail.',
  `driver_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_stake_holder_master',
  `qty` int(11) DEFAULT NULL COMMENT 'Quantity',
  `amount_unit` decimal(10,2) DEFAULT NULL COMMENT 'Unit price',
  `amount` decimal(10,2) DEFAULT NULL COMMENT 'Amount',
  `account_group` varchar(100) DEFAULT NULL COMMENT 'Account group',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `generate_type` varchar(255) DEFAULT NULL COMMENT 'Generate type',
  `with_draw` int(11) DEFAULT NULL COMMENT 'Status of withdraw',
  `status` int(11) DEFAULT NULL COMMENT 'Status',
  `pay_to` varchar(255) DEFAULT NULL COMMENT 'Pay to driver',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user',
  `allowance_no` varchar(255) DEFAULT NULL COMMENT 'FK FROM tb_allowance_master',
  `allowance_sub_no` varchar(255) DEFAULT NULL COMMENT 'FK FROM tb_allowance_sub_master',
  `petty_cash_no` varchar(255) DEFAULT NULL COMMENT 'FK FROM tb_petty_cash_master',
  `amount_petty_cash` double(22,2) DEFAULT NULL COMMENT 'Amount of petty cash',
  `route_detail_id` bigint(20) DEFAULT NULL,
  `route_id` bigint(20) DEFAULT NULL,
  `job_route_id` bigint(20) DEFAULT NULL,
  `truck_tractor_id` bigint(20) DEFAULT NULL,
  `reference_no` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_cost2021_2023`
--

CREATE TABLE `tb_job_cost2021_2023` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_master',
  `route_truck_cost_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_route_truck_cost.',
  `truck_cost_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_cost_master.',
  `truck_cost_detail_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_cost_detail.',
  `driver_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_stake_holder_master',
  `qty` int(11) DEFAULT NULL COMMENT 'Quantity',
  `amount_unit` decimal(10,2) DEFAULT NULL COMMENT 'Unit price',
  `amount` decimal(10,2) DEFAULT NULL COMMENT 'Amount',
  `account_group` varchar(100) DEFAULT NULL COMMENT 'Account group',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `generate_type` varchar(255) DEFAULT NULL COMMENT 'Generate type',
  `with_draw` int(11) DEFAULT NULL COMMENT 'Status of withdraw',
  `status` int(11) DEFAULT NULL COMMENT 'Status',
  `pay_to` varchar(255) DEFAULT NULL COMMENT 'Pay to driver',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user',
  `allowance_no` varchar(255) DEFAULT NULL COMMENT 'FK FROM tb_allowance_master',
  `allowance_sub_no` varchar(255) DEFAULT NULL COMMENT 'FK FROM tb_allowance_sub_master',
  `petty_cash_no` varchar(255) DEFAULT NULL COMMENT 'FK FROM tb_petty_cash_master',
  `amount_petty_cash` double(22,2) DEFAULT NULL COMMENT 'Amount of petty cash',
  `route_detail_id` bigint(20) DEFAULT NULL,
  `route_id` bigint(20) DEFAULT NULL,
  `job_route_id` bigint(20) DEFAULT NULL,
  `truck_tractor_id` bigint(20) DEFAULT NULL,
  `reference_no` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_fuel`
--

CREATE TABLE `tb_job_fuel` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_master',
  `job_route_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_route',
  `gas_station_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_stake_holder_master',
  `mileage` double(22,4) DEFAULT NULL COMMENT 'Mileage',
  `mileage_amount` double(22,4) DEFAULT NULL COMMENT 'Total mileage',
  `liter` double(22,4) DEFAULT NULL COMMENT 'Liter',
  `liter_rate` double(22,4) DEFAULT NULL COMMENT 'Liter rate',
  `total_amount` double(22,4) DEFAULT NULL COMMENT 'Amount',
  `status` int(11) DEFAULT NULL COMMENT 'Status',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `inv_no` varchar(255) DEFAULT NULL COMMENT 'Invoice No(Free Text)',
  `type` varchar(255) DEFAULT NULL COMMENT 'type',
  `entry_date` datetime DEFAULT NULL COMMENT 'Entry date',
  `truck_tractor_id` bigint(20) DEFAULT NULL,
  `gsdb_id` bigint(20) DEFAULT NULL,
  `driver_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_fuel2021_2023`
--

CREATE TABLE `tb_job_fuel2021_2023` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_master',
  `job_route_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_route',
  `gas_station_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_stake_holder_master',
  `mileage` double(22,4) DEFAULT NULL COMMENT 'Mileage',
  `mileage_amount` double(22,4) DEFAULT NULL COMMENT 'Total mileage',
  `liter` double(22,4) DEFAULT NULL COMMENT 'Liter',
  `liter_rate` double(22,4) DEFAULT NULL COMMENT 'Liter rate',
  `total_amount` double(22,4) DEFAULT NULL COMMENT 'Amount',
  `status` int(11) DEFAULT NULL COMMENT 'Status',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `inv_no` varchar(255) DEFAULT NULL COMMENT 'Invoice No(Free Text)',
  `type` varchar(255) DEFAULT NULL COMMENT 'type',
  `entry_date` datetime DEFAULT NULL COMMENT 'Entry date',
  `truck_tractor_id` bigint(20) DEFAULT NULL,
  `gsdb_id` bigint(20) DEFAULT NULL,
  `driver_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_fuel_input`
--

CREATE TABLE `tb_job_fuel_input` (
  `fuel_id` varchar(100) NOT NULL,
  `job_id` varchar(100) DEFAULT NULL,
  `mileage` varchar(100) DEFAULT NULL,
  `litr_amount` varchar(100) DEFAULT NULL,
  `fuel_rate` varchar(100) DEFAULT NULL,
  `total_amount` varchar(100) DEFAULT NULL,
  `action_by` varchar(100) DEFAULT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `create_by` varchar(100) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_by` varchar(100) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `action_date` datetime DEFAULT NULL,
  `gas_station` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_fuel_rate`
--

CREATE TABLE `tb_job_fuel_rate` (
  `fuel_rate_id` varchar(100) NOT NULL,
  `job_id` varchar(100) DEFAULT NULL,
  `load_stop` varchar(100) DEFAULT NULL,
  `mileage` varchar(100) DEFAULT NULL,
  `distance_amout` varchar(100) DEFAULT NULL,
  `litr_amount` varchar(100) DEFAULT NULL,
  `fuel_rate` varchar(100) DEFAULT NULL,
  `line_amount` varchar(100) DEFAULT NULL,
  `create_by` varchar(100) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_by` varchar(100) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_income`
--

CREATE TABLE `tb_job_income` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_master',
  `income_type_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_income_type',
  `detail` varchar(255) DEFAULT NULL COMMENT 'Detail',
  `qty` int(11) DEFAULT NULL COMMENT 'Quantity',
  `amount` double(22,2) DEFAULT NULL COMMENT 'Amount',
  `amount_unit` double(22,2) DEFAULT NULL COMMENT 'Unit price',
  `account_group` varchar(255) DEFAULT NULL COMMENT 'Account group',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_income2021_2023`
--

CREATE TABLE `tb_job_income2021_2023` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_master',
  `income_type_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_income_type',
  `detail` varchar(255) DEFAULT NULL COMMENT 'Detail',
  `qty` int(11) DEFAULT NULL COMMENT 'Quantity',
  `amount` double(22,2) DEFAULT NULL COMMENT 'Amount',
  `amount_unit` double(22,2) DEFAULT NULL COMMENT 'Unit price',
  `account_group` varchar(255) DEFAULT NULL COMMENT 'Account group',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_master`
--

CREATE TABLE `tb_job_master` (
  `job_id` bigint(20) NOT NULL COMMENT 'PK',
  `job_no` varchar(100) DEFAULT NULL COMMENT 'Job code',
  `quotation_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_quotation',
  `quotation_item_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_quotation_item',
  `customer_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_stake_holder_master',
  `route_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_route_master',
  `route_truck_type_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_route_truck_type',
  `truck_type_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_type',
  `trip_type` varchar(100) DEFAULT NULL COMMENT 'Types of trips',
  `truck_tractor_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_profile',
  `truck_trailer_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_profile',
  `user_id` int(11) DEFAULT NULL COMMENT '-',
  `driver_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user',
  `driver_id_2` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user',
  `booking_no` varchar(100) DEFAULT NULL COMMENT 'Booking no',
  `container_no` varchar(100) DEFAULT NULL COMMENT 'Container no',
  `booking_name` varchar(100) DEFAULT NULL COMMENT 'Booking name',
  `booking_contact_tel_no` varchar(100) DEFAULT NULL COMMENT 'Booking tel no',
  `contact_name` varchar(100) DEFAULT NULL COMMENT 'Contact name',
  `contact_tel_no` varchar(100) DEFAULT NULL COMMENT 'Contact tel no',
  `pallet_no` decimal(10,2) DEFAULT NULL COMMENT 'Num of pallet',
  `rack_no` decimal(10,2) DEFAULT NULL COMMENT 'Num of rack',
  `box_no` decimal(10,2) DEFAULT NULL COMMENT 'Num of box',
  `truck_capacity` decimal(10,2) DEFAULT NULL COMMENT 'Truck capacity',
  `volumn_detail` varchar(100) DEFAULT NULL COMMENT 'Volume detail',
  `truck_utilization` decimal(10,2) DEFAULT NULL COMMENT 'Truck utilization',
  `reason_for_truck_type` decimal(10,2) DEFAULT NULL COMMENT '-',
  `job_remark` varchar(100) DEFAULT NULL COMMENT 'Remark',
  `status` tinyint(4) DEFAULT NULL COMMENT 'Status',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `invoice_no` varchar(100) DEFAULT NULL COMMENT 'FK FROM tb_invoice_master',
  `rpt_flag` int(11) DEFAULT NULL COMMENT '-',
  `stamp_date` datetime DEFAULT NULL COMMENT 'Job created date',
  `job_status` varchar(255) DEFAULT NULL COMMENT 'Job status',
  `in_mileage` double(22,0) DEFAULT NULL COMMENT 'Mileage to the yard',
  `out_mileage` double(22,0) DEFAULT NULL COMMENT 'Mileage out the yard',
  `container_size_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_container_size',
  `allowance_no` varchar(255) DEFAULT NULL COMMENT '-',
  `status_receive` int(11) DEFAULT NULL,
  `cost_truck_type_id` bigint(20) DEFAULT NULL,
  `driver_id_3` bigint(20) DEFAULT NULL,
  `driver_id_4` bigint(20) DEFAULT NULL,
  `return_job_no_sbg` varchar(255) DEFAULT NULL,
  `completed_delivery_status` char(1) DEFAULT NULL,
  `completed_pickup_status` char(1) DEFAULT NULL,
  `transport_status` varchar(50) DEFAULT NULL,
  `create_shipment` int(1) DEFAULT 0,
  `start_system_in` int(1) DEFAULT 0,
  `end_system_out` int(1) DEFAULT 0,
  `start_system_in_time` datetime DEFAULT NULL,
  `start_system_out_time` datetime DEFAULT NULL,
  `job_class` int(2) DEFAULT 0,
  `seal_no` varchar(150) DEFAULT NULL,
  `container_weight` varchar(150) DEFAULT NULL,
  `container_yard` varchar(150) DEFAULT NULL,
  `port` varchar(150) DEFAULT NULL,
  `agent` varchar(150) DEFAULT NULL,
  `closing_date` datetime DEFAULT NULL,
  `reference_no` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_master2021_2023`
--

CREATE TABLE `tb_job_master2021_2023` (
  `job_id` bigint(20) NOT NULL COMMENT 'PK',
  `job_no` varchar(100) DEFAULT NULL COMMENT 'Job code',
  `quotation_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_quotation',
  `quotation_item_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_quotation_item',
  `customer_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_stake_holder_master',
  `route_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_route_master',
  `route_truck_type_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_route_truck_type',
  `truck_type_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_type',
  `trip_type` varchar(100) DEFAULT NULL COMMENT 'Types of trips',
  `truck_tractor_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_profile',
  `truck_trailer_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_profile',
  `user_id` int(11) DEFAULT NULL COMMENT '-',
  `driver_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user',
  `driver_id_2` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user',
  `booking_no` varchar(100) DEFAULT NULL COMMENT 'Booking no',
  `container_no` varchar(100) DEFAULT NULL COMMENT 'Container no',
  `booking_name` varchar(100) DEFAULT NULL COMMENT 'Booking name',
  `booking_contact_tel_no` varchar(100) DEFAULT NULL COMMENT 'Booking tel no',
  `contact_name` varchar(100) DEFAULT NULL COMMENT 'Contact name',
  `contact_tel_no` varchar(100) DEFAULT NULL COMMENT 'Contact tel no',
  `pallet_no` decimal(10,2) DEFAULT NULL COMMENT 'Num of pallet',
  `rack_no` decimal(10,2) DEFAULT NULL COMMENT 'Num of rack',
  `box_no` decimal(10,2) DEFAULT NULL COMMENT 'Num of box',
  `truck_capacity` decimal(10,2) DEFAULT NULL COMMENT 'Truck capacity',
  `volumn_detail` varchar(100) DEFAULT NULL COMMENT 'Volume detail',
  `truck_utilization` decimal(10,2) DEFAULT NULL COMMENT 'Truck utilization',
  `reason_for_truck_type` decimal(10,2) DEFAULT NULL COMMENT '-',
  `job_remark` varchar(100) DEFAULT NULL COMMENT 'Remark',
  `status` tinyint(4) DEFAULT NULL COMMENT 'Status',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `invoice_no` varchar(100) DEFAULT NULL COMMENT 'FK FROM tb_invoice_master',
  `rpt_flag` int(11) DEFAULT NULL COMMENT '-',
  `stamp_date` datetime DEFAULT NULL COMMENT 'Job created date',
  `job_status` varchar(255) DEFAULT NULL COMMENT 'Job status',
  `in_mileage` double(22,0) DEFAULT NULL COMMENT 'Mileage to the yard',
  `out_mileage` double(22,0) DEFAULT NULL COMMENT 'Mileage out the yard',
  `container_size_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_container_size',
  `allowance_no` varchar(255) DEFAULT NULL COMMENT '-',
  `status_receive` int(11) DEFAULT NULL,
  `cost_truck_type_id` bigint(20) DEFAULT NULL,
  `driver_id_3` bigint(20) DEFAULT NULL,
  `driver_id_4` bigint(20) DEFAULT NULL,
  `return_job_no_sbg` varchar(255) DEFAULT NULL,
  `completed_delivery_status` char(1) DEFAULT NULL,
  `completed_pickup_status` char(1) DEFAULT NULL,
  `transport_status` varchar(50) DEFAULT NULL,
  `create_shipment` int(1) DEFAULT 0,
  `start_system_in` int(1) DEFAULT 0,
  `end_system_out` int(1) DEFAULT 0,
  `start_system_in_time` datetime DEFAULT NULL,
  `start_system_out_time` datetime DEFAULT NULL,
  `job_class` int(2) DEFAULT 0,
  `seal_no` varchar(150) DEFAULT NULL,
  `container_weight` varchar(150) DEFAULT NULL,
  `container_yard` varchar(150) DEFAULT NULL,
  `port` varchar(150) DEFAULT NULL,
  `agent` varchar(150) DEFAULT NULL,
  `closing_date` datetime DEFAULT NULL,
  `reference_no` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_notification`
--

CREATE TABLE `tb_job_notification` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `load_date` datetime DEFAULT NULL,
  `load_date_str` varchar(255) DEFAULT NULL,
  `load_id` varchar(255) DEFAULT NULL,
  `load_stopid` bigint(20) DEFAULT NULL,
  `previous_page` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `stop_shipping_location` varchar(255) DEFAULT NULL,
  `system_loadid` varchar(255) DEFAULT NULL,
  `waybill_number` varchar(255) DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_order_template_download`
--

CREATE TABLE `tb_job_order_template_download` (
  `id` bigint(20) NOT NULL,
  `token` varchar(100) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `user_display_name` varchar(200) DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` timestamp NULL DEFAULT NULL,
  `used` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_reserve_payment`
--

CREATE TABLE `tb_job_reserve_payment` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `account_group` varchar(255) DEFAULT NULL COMMENT 'Account group',
  `amount` double(22,0) DEFAULT NULL COMMENT 'Amount',
  `amount_unit` double(22,0) DEFAULT NULL COMMENT 'Unit price',
  `name` varchar(255) DEFAULT NULL COMMENT '-',
  `qty` double(22,0) DEFAULT NULL COMMENT 'Quantity',
  `status` int(11) DEFAULT NULL COMMENT 'Status',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_master',
  `advance_payment_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_advance_payment_master',
  `truck_cost_detail_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_cost_detail'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_reserve_payment2021_2023`
--

CREATE TABLE `tb_job_reserve_payment2021_2023` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `account_group` varchar(255) DEFAULT NULL COMMENT 'Account group',
  `amount` double(22,0) DEFAULT NULL COMMENT 'Amount',
  `amount_unit` double(22,0) DEFAULT NULL COMMENT 'Unit price',
  `name` varchar(255) DEFAULT NULL COMMENT '-',
  `qty` double(22,0) DEFAULT NULL COMMENT 'Quantity',
  `status` int(11) DEFAULT NULL COMMENT 'Status',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_master',
  `advance_payment_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_advance_payment_master',
  `truck_cost_detail_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_cost_detail'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_route`
--

CREATE TABLE `tb_job_route` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_master',
  `route_id` bigint(20) DEFAULT NULL COMMENT '-',
  `route_detail_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_route_detail',
  `plan_in` datetime DEFAULT NULL COMMENT 'Plan time of arrival',
  `plan_out` datetime DEFAULT NULL COMMENT 'Plan time of departure',
  `actual_in` datetime DEFAULT NULL COMMENT 'Actual time of arrival',
  `actual_out` datetime DEFAULT NULL COMMENT 'Actual time of departure',
  `eta` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT 'Status',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `track_status` varchar(255) DEFAULT NULL COMMENT 'Transport status',
  `service_type` varchar(255) DEFAULT NULL COMMENT '-',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type',
  `actual_in_gps` datetime DEFAULT NULL,
  `actual_out_gps` datetime DEFAULT NULL,
  `gsdb_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_gsdb_code',
  `box_no` decimal(10,2) DEFAULT NULL COMMENT 'Number of box',
  `pallet_no` decimal(10,2) DEFAULT NULL COMMENT 'Number of pallet',
  `rack_no` decimal(10,2) DEFAULT NULL COMMENT 'Number of rack',
  `check_in_date` datetime DEFAULT NULL,
  `check_in_latitude` double DEFAULT NULL,
  `check_in_longitude` double DEFAULT NULL,
  `check_in_status` int(11) DEFAULT NULL,
  `check_out_status` int(11) DEFAULT NULL,
  `check_out_date` datetime DEFAULT NULL,
  `delay_cause_code` varchar(255) DEFAULT NULL,
  `delay_cause_remark` text DEFAULT NULL,
  `actual_in2` datetime DEFAULT NULL,
  `actual_out2` datetime DEFAULT NULL,
  `driver_id` bigint(20) DEFAULT NULL,
  `plan_in2` datetime DEFAULT NULL,
  `plan_out2` datetime DEFAULT NULL,
  `truck_tractor_id` bigint(20) DEFAULT NULL,
  `truck_trailer_id` bigint(20) DEFAULT NULL,
  `gsdb_id2` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_route2021_2023`
--

CREATE TABLE `tb_job_route2021_2023` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_job_master',
  `route_id` bigint(20) DEFAULT NULL COMMENT '-',
  `route_detail_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_route_detail',
  `plan_in` datetime DEFAULT NULL COMMENT 'Plan time of arrival',
  `plan_out` datetime DEFAULT NULL COMMENT 'Plan time of departure',
  `actual_in` datetime DEFAULT NULL COMMENT 'Actual time of arrival',
  `actual_out` datetime DEFAULT NULL COMMENT 'Actual time of departure',
  `eta` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT 'Status',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `track_status` varchar(255) DEFAULT NULL COMMENT 'Transport status',
  `service_type` varchar(255) DEFAULT NULL COMMENT '-',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type',
  `actual_in_gps` datetime DEFAULT NULL,
  `actual_out_gps` datetime DEFAULT NULL,
  `gsdb_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_gsdb_code',
  `box_no` decimal(10,2) DEFAULT NULL COMMENT 'Number of box',
  `pallet_no` decimal(10,2) DEFAULT NULL COMMENT 'Number of pallet',
  `rack_no` decimal(10,2) DEFAULT NULL COMMENT 'Number of rack',
  `check_in_date` datetime DEFAULT NULL,
  `check_in_latitude` double DEFAULT NULL,
  `check_in_longitude` double DEFAULT NULL,
  `check_in_status` int(11) DEFAULT NULL,
  `check_out_status` int(11) DEFAULT NULL,
  `check_out_date` datetime DEFAULT NULL,
  `delay_cause_code` varchar(255) DEFAULT NULL,
  `delay_cause_remark` text DEFAULT NULL,
  `actual_in2` datetime DEFAULT NULL,
  `actual_out2` datetime DEFAULT NULL,
  `driver_id` bigint(20) DEFAULT NULL,
  `plan_in2` datetime DEFAULT NULL,
  `plan_out2` datetime DEFAULT NULL,
  `truck_tractor_id` bigint(20) DEFAULT NULL,
  `truck_trailer_id` bigint(20) DEFAULT NULL,
  `gsdb_id2` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_job_type`
--

CREATE TABLE `tb_job_type` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `name` varchar(255) DEFAULT NULL COMMENT 'name',
  `status` int(11) DEFAULT NULL COMMENT 'status'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_load`
--

CREATE TABLE `tb_load` (
  `loadID` int(11) NOT NULL,
  `carrierID` int(11) NOT NULL,
  `systemLoadID` int(11) NOT NULL,
  `completedFlag` varchar(20) NOT NULL DEFAULT '',
  `errorMessage` text DEFAULT NULL,
  `lastUpdateDate` datetime DEFAULT NULL,
  `lastUpdateUser` varchar(20) DEFAULT NULL,
  `alertTypeCode` varchar(20) DEFAULT NULL,
  `loadDescription` varchar(255) DEFAULT NULL,
  `loadStartDateTime` datetime DEFAULT NULL,
  `loadEndDateTime` datetime DEFAULT NULL,
  `loadAction` varchar(50) DEFAULT NULL,
  `gatein` varchar(50) DEFAULT NULL,
  `gateout` varchar(50) DEFAULT NULL,
  `assigntime` datetime DEFAULT NULL,
  `driverId` varchar(25) DEFAULT NULL,
  `dateassign` datetime DEFAULT NULL,
  `dateaccept` datetime DEFAULT NULL,
  `assignname` varchar(25) DEFAULT NULL,
  `nostraStatus` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `nostraRemark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `etaColor` varchar(200) DEFAULT NULL,
  `shipmentStatusId` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_loadstop`
--

CREATE TABLE `tb_loadstop` (
  `SystemLoads` int(11) NOT NULL DEFAULT 0,
  `id` int(11) NOT NULL,
  `loadID` int(11) NOT NULL,
  `stopSequence` tinyint(2) NOT NULL,
  `stopShippingLocation` varchar(255) NOT NULL DEFAULT '',
  `truckNumber` varchar(100) DEFAULT NULL,
  `departureTime` datetime DEFAULT NULL,
  `arriveTime` datetime DEFAULT NULL,
  `completedFlag` varchar(10) DEFAULT '',
  `errorMessage` text DEFAULT NULL,
  `lastUpdateDate` datetime DEFAULT NULL,
  `lastUpdateUser` varchar(20) DEFAULT NULL,
  `stopShippingLocationName` varchar(255) DEFAULT NULL,
  `shipingOrder` varchar(70) DEFAULT NULL,
  `waybillNumber` varchar(70) DEFAULT NULL,
  `maniFest` varchar(50) DEFAULT NULL,
  `loadstopremark` varchar(255) DEFAULT NULL,
  `statusLoad` varchar(20) DEFAULT NULL,
  `latitude` decimal(10,6) DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `loadstopYardCode` varchar(50) DEFAULT NULL,
  `actualStartDate` datetime DEFAULT NULL,
  `actualEndDate` datetime DEFAULT NULL,
  `etaDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_lock_report_ctrl`
--

CREATE TABLE `tb_lock_report_ctrl` (
  `id` bigint(20) NOT NULL,
  `active` varchar(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_log_advance_payment_master`
--

CREATE TABLE `tb_log_advance_payment_master` (
  `id` bigint(20) NOT NULL,
  `activity_status` char(1) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `rq_no` varchar(255) DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_log_allowance_master`
--

CREATE TABLE `tb_log_allowance_master` (
  `id` bigint(20) NOT NULL,
  `activity_status` char(1) DEFAULT NULL,
  `allowance_no` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_log_invoice_master`
--

CREATE TABLE `tb_log_invoice_master` (
  `id` bigint(20) NOT NULL,
  `activity_status` char(1) DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_log_job_cost`
--

CREATE TABLE `tb_log_job_cost` (
  `id` bigint(20) NOT NULL,
  `job_cost_id` bigint(20) NOT NULL COMMENT 'รหัส Job Cost ที่เก็บ log',
  `log_user` varchar(100) DEFAULT NULL COMMENT 'ผู้ใช้ที่สร้างหรือแก้ไข',
  `action_type` varchar(10) NOT NULL COMMENT 'ประเภทการทำงาน CREATE หรือ EDIT',
  `log_timestamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่และเวลาที่บันทึก log',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'Job ID',
  `route_id` bigint(20) DEFAULT NULL COMMENT 'Route ID',
  `route_detail_id` bigint(20) DEFAULT NULL COMMENT 'Route Detail ID',
  `route_truck_cost_id` bigint(20) DEFAULT NULL COMMENT 'Route Truck Cost ID',
  `truck_cost_id` bigint(20) DEFAULT NULL COMMENT 'Truck Cost ID',
  `truck_cost_detail_id` bigint(20) DEFAULT NULL COMMENT 'Truck Cost Detail ID',
  `truck_tractor_id` bigint(20) DEFAULT NULL COMMENT 'Truck Tractor ID',
  `driver_id` bigint(20) DEFAULT NULL COMMENT 'Driver ID',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT 'Supplier ID',
  `qty` int(11) DEFAULT NULL COMMENT 'Quantity',
  `amount_unit` decimal(15,4) DEFAULT NULL COMMENT 'Amount Unit',
  `amount` decimal(15,2) DEFAULT NULL COMMENT 'Amount',
  `account_group` varchar(100) DEFAULT NULL COMMENT 'Account Group',
  `generate_type` varchar(10) DEFAULT NULL COMMENT 'Generate Type',
  `with_draw` int(11) DEFAULT NULL COMMENT 'With Draw',
  `status` int(11) DEFAULT NULL COMMENT 'Status',
  `pay_to` text DEFAULT NULL COMMENT 'Pay To',
  `allowance_no` varchar(50) DEFAULT NULL COMMENT 'Allowance Number',
  `allowance_sub_no` varchar(50) DEFAULT NULL COMMENT 'Allowance Sub Number',
  `petty_cash_no` varchar(50) DEFAULT NULL COMMENT 'Petty Cash Number',
  `reference_no` varchar(100) DEFAULT NULL COMMENT 'Reference Number',
  `amount_petty_cash` decimal(15,2) DEFAULT NULL COMMENT 'Amount Petty Cash',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'ผู้ที่สร้าง',
  `created_date` timestamp NULL DEFAULT NULL COMMENT 'วันที่สร้าง',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'ผู้ที่แก้ไข',
  `updated_date` timestamp NULL DEFAULT NULL COMMENT 'วันที่แก้ไข'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ตาราง log สำหรับ tb_job_cost';

-- --------------------------------------------------------

--
-- Table structure for table `tb_log_job_master`
--

CREATE TABLE `tb_log_job_master` (
  `id` bigint(20) NOT NULL,
  `activity` varchar(255) DEFAULT NULL,
  `job_no` varchar(255) DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_log_job_route`
--

CREATE TABLE `tb_log_job_route` (
  `id` bigint(20) NOT NULL,
  `job_route_id` bigint(20) NOT NULL COMMENT 'รหัส Job Route ที่เก็บ log',
  `log_user` varchar(100) DEFAULT NULL COMMENT 'ผู้ใช้ที่สร้างหรือแก้ไข',
  `action_type` varchar(10) NOT NULL COMMENT 'ประเภทการทำงาน CREATE หรือ EDIT',
  `log_timestamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่และเวลาที่บันทึก log',
  `job_id` bigint(20) DEFAULT NULL COMMENT 'Job ID',
  `route_id` bigint(20) DEFAULT NULL COMMENT 'Route ID',
  `route_detail_id` bigint(20) DEFAULT NULL COMMENT 'Route Detail ID',
  `actual_in` timestamp NULL DEFAULT NULL COMMENT 'Actual In',
  `actual_out` timestamp NULL DEFAULT NULL COMMENT 'Actual Out',
  `plan_in` timestamp NULL DEFAULT NULL COMMENT 'Plan In',
  `plan_out` timestamp NULL DEFAULT NULL COMMENT 'Plan Out',
  `status` int(11) DEFAULT NULL COMMENT 'Status',
  `track_status` varchar(50) DEFAULT NULL COMMENT 'Track Status',
  `type` varchar(1) DEFAULT NULL COMMENT 'Type (A=Auto, M=Manual)',
  `actual_in2` timestamp NULL DEFAULT NULL COMMENT 'Actual In 2',
  `actual_out2` timestamp NULL DEFAULT NULL COMMENT 'Actual Out 2',
  `plan_in2` timestamp NULL DEFAULT NULL COMMENT 'Plan In 2',
  `plan_out2` timestamp NULL DEFAULT NULL COMMENT 'Plan Out 2',
  `truck_tractor_id` bigint(20) DEFAULT NULL COMMENT 'Truck Tractor ID',
  `truck_trailer_id` bigint(20) DEFAULT NULL COMMENT 'Truck Trailer ID',
  `driver_id` bigint(20) DEFAULT NULL COMMENT 'Driver ID',
  `gsdb_id` bigint(20) DEFAULT NULL COMMENT 'GSDB ID',
  `gsdb_id2` bigint(20) DEFAULT NULL COMMENT 'GSDB ID 2',
  `service_type` varchar(100) DEFAULT NULL COMMENT 'Service Type',
  `pallet_no` decimal(10,2) DEFAULT NULL COMMENT 'Pallet Number',
  `rack_no` decimal(10,2) DEFAULT NULL COMMENT 'Rack Number',
  `box_no` decimal(10,2) DEFAULT NULL COMMENT 'Box Number',
  `check_in_status` int(11) DEFAULT NULL COMMENT 'Check In Status',
  `check_out_status` int(11) DEFAULT NULL COMMENT 'Check Out Status',
  `check_in_date` timestamp NULL DEFAULT NULL COMMENT 'Check In Date',
  `check_out_date` timestamp NULL DEFAULT NULL COMMENT 'Check Out Date',
  `check_in_latitude` decimal(10,6) DEFAULT NULL COMMENT 'Check In Latitude',
  `check_in_longitude` decimal(10,6) DEFAULT NULL COMMENT 'Check In Longitude',
  `delay_cause_code` varchar(100) DEFAULT NULL COMMENT 'Delay Cause Code',
  `delay_cause_remark` text DEFAULT NULL COMMENT 'Delay Cause Remark',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'ผู้ที่สร้าง',
  `created_date` timestamp NULL DEFAULT NULL COMMENT 'วันที่สร้าง',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'ผู้ที่แก้ไข',
  `updated_date` timestamp NULL DEFAULT NULL COMMENT 'วันที่แก้ไข'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ตาราง log สำหรับ tb_job_route';

-- --------------------------------------------------------

--
-- Table structure for table `tb_log_receipt_master`
--

CREATE TABLE `tb_log_receipt_master` (
  `id` bigint(20) NOT NULL,
  `activity_status` char(1) DEFAULT NULL,
  `receipt_no` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_log_receipt_ra_master`
--

CREATE TABLE `tb_log_receipt_ra_master` (
  `id` bigint(20) NOT NULL,
  `activity_status` char(1) DEFAULT NULL,
  `receipt_ra_no` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_log_sr_master`
--

CREATE TABLE `tb_log_sr_master` (
  `id` bigint(20) NOT NULL,
  `activity_status` char(1) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `sr_no` varchar(255) DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_maintenance`
--

CREATE TABLE `tb_maintenance` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated by date',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `current_mileage` double(22,0) DEFAULT NULL COMMENT 'เลขไมล์ปัจจุบัน',
  `doc_no` varchar(255) DEFAULT NULL COMMENT 'Document no',
  `garage` varchar(255) DEFAULT NULL COMMENT 'ประเภทอู่',
  `mileage` double(22,0) DEFAULT NULL COMMENT '-',
  `notification_date` datetime DEFAULT NULL COMMENT 'วันที่แจ้งเตือน',
  `remark` varchar(255) DEFAULT NULL COMMENT 'หมายเหตุ',
  `repair_date` datetime DEFAULT NULL COMMENT 'วันที่เข้าซ่อมบำรุง',
  `status` int(11) DEFAULT NULL COMMENT 'สถานะการใช้งาน',
  `type` varchar(255) DEFAULT NULL COMMENT 'ประเภทการซ่อมบำรุง',
  `driver_id` bigint(20) DEFAULT NULL COMMENT 'พนง.ขับรถ1(FK FROM tb_user)',
  `repairman_id` bigint(20) DEFAULT NULL COMMENT 'ชื่อช่างซ่อมบำรุง1(FK FROM tb_user)',
  `repairman_id_2` bigint(20) DEFAULT NULL COMMENT 'ชื่อช่างซ่อมบำรุง2(FK FROM tb_user)',
  `truck_profile_id` bigint(20) DEFAULT NULL COMMENT 'ทะเบียน(FK FROM tb_truck_profile)',
  `track_status` varchar(255) DEFAULT NULL COMMENT 'สถานะของ MA',
  `driver_id_2` bigint(20) DEFAULT NULL COMMENT 'พนักงานขับรถที่นำรถมาซ่อม(FK FROM tb_user)',
  `project_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_project',
  `yard_id` bigint(20) DEFAULT NULL COMMENT 'สถานที่ซ่อม(FK FROM tb_user_yard)',
  `brand` varchar(255) DEFAULT NULL COMMENT 'ยี่ห้อ',
  `fuel_type` varchar(255) DEFAULT NULL COMMENT 'ประเภทเชื้อเพลิง',
  `master_preventive_setup_item_id` bigint(20) DEFAULT NULL COMMENT 'รายละเอียดการตรวจเช็คตามระยะ PM(FK FROM tb_master_preventive_setup_item) ',
  `stake_holder_id` bigint(20) DEFAULT NULL COMMENT 'อู่ซ่อมรถ(FK FROM tb_stake_holder_master)',
  `approved_by` varchar(100) DEFAULT NULL COMMENT 'Approved by user',
  `approved_date` datetime DEFAULT NULL COMMENT 'Approved date',
  `stamp_off_date` datetime DEFAULT NULL COMMENT 'วันที่ปิดการใช้งาน',
  `stamp_off_detail` mediumtext DEFAULT NULL COMMENT 'หมายเหตุการปิดการใช้งาน',
  `ma_invoice_no` varchar(255) DEFAULT NULL COMMENT 'MaInvoice(FK FROM tb_maintenance_invoice)',
  `closed_by` varchar(100) DEFAULT NULL,
  `closed_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_maintenance_invoice`
--

CREATE TABLE `tb_maintenance_invoice` (
  `ma_invoice_no` varchar(50) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `ma_invoice_status` char(1) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `stamp_date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `total_amount` decimal(19,2) DEFAULT NULL,
  `maintenance_id` bigint(20) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_maintenance_preventive`
--

CREATE TABLE `tb_maintenance_preventive` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `detail` mediumtext DEFAULT NULL COMMENT 'รายละเอียด',
  `stamp_date` datetime DEFAULT NULL COMMENT 'วันที่สร้าง',
  `status` int(11) NOT NULL COMMENT 'สถานะการใช้งาน',
  `type` varchar(255) DEFAULT NULL COMMENT 'ประเภท',
  `ma_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_maintenance',
  `preventive_checklist_id` bigint(20) DEFAULT NULL COMMENT 'รายการตรวจ',
  `preventive_setup_detail_id` bigint(20) DEFAULT NULL COMMENT 'รายละเอียดการตรวจจากPreventive Setup Plan(FK FROM tb_master_preventive_setup_detail)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_maintenance_service_cost`
--

CREATE TABLE `tb_maintenance_service_cost` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `amount` decimal(19,4) DEFAULT NULL COMMENT 'รวมเงิน',
  `file_name` varchar(255) DEFAULT NULL COMMENT 'File name',
  `file_size` int(11) DEFAULT NULL COMMENT 'File size',
  `price` decimal(10,4) DEFAULT NULL COMMENT 'ราคาต่อหน่วย',
  `qty` decimal(10,2) DEFAULT NULL,
  `remark` mediumtext DEFAULT NULL COMMENT 'หมายเหตุ',
  `stamp_date` datetime DEFAULT NULL COMMENT 'วันที่สร้างรายการ',
  `start_date` datetime DEFAULT NULL COMMENT 'วันที่เริ่มซ่อม',
  `end_date` datetime DEFAULT NULL COMMENT 'วันที่สิ้นสุดการซ่อม',
  `status` int(11) NOT NULL COMMENT 'สถานะการใช้งาน',
  `thumbnail` mediumtext DEFAULT NULL COMMENT 'thumbnail',
  `type` varchar(255) DEFAULT NULL COMMENT 'type',
  `uuid` varchar(255) DEFAULT NULL COMMENT 'uuid',
  `ma_id` bigint(20) DEFAULT NULL COMMENT 'MA(FK FROM tb_maintenance)',
  `ma_spare_part_id` bigint(20) DEFAULT NULL COMMENT 'รายการอะไหล่ที่ซ่อม(FK FROM tb_maintenance_spare_part)',
  `ma_service_type_id` bigint(20) DEFAULT NULL COMMENT 'ประเภทการซ่อม(FK FROM tb_master_maintenance_service_cost_type)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_maintenance_spare_part`
--

CREATE TABLE `tb_maintenance_spare_part` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `qty` decimal(10,2) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL COMMENT 'หมายเหตุ',
  `stamp_date` datetime DEFAULT NULL COMMENT 'วันที่สร้างรายการ',
  `status` int(11) NOT NULL COMMENT 'สถานะการใช้งาน',
  `maintenance_id` bigint(20) DEFAULT NULL COMMENT 'MA(FK FROM tb_maintenance)',
  `spare_parts_stock_id` bigint(20) DEFAULT NULL COMMENT 'รายการอะไหล่(FK FROM tb_spare_parts_stock)',
  `type` varchar(255) DEFAULT NULL COMMENT 'ประเภทการซ่อม',
  `track_status` char(1) DEFAULT NULL COMMENT 'สถานะการเบิกใช้งาน',
  `price` decimal(10,4) DEFAULT NULL COMMENT 'ราคา'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_maintenance_tire`
--

CREATE TABLE `tb_maintenance_tire` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `distance` decimal(10,4) DEFAULT NULL COMMENT 'ระยะทาง',
  `mileage` decimal(10,4) DEFAULT NULL COMMENT 'เลขไมล์ปัจจุบัน',
  `position_no` int(11) NOT NULL COMMENT 'ตำแหน่งยาง',
  `qty` decimal(10,2) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL COMMENT 'หมายเหตุ',
  `stamp_date` datetime DEFAULT NULL COMMENT 'วันที่สร้างรายการ',
  `status` int(11) NOT NULL COMMENT 'สถานะการใช้งาน',
  `tire_no` varchar(255) DEFAULT NULL COMMENT 'หมายเลขยางใหม่',
  `maintenance_id` bigint(20) DEFAULT NULL COMMENT 'MA(FK FROM tb_maintenance)',
  `pre_history_tire_id` bigint(20) DEFAULT NULL COMMENT 'หมายเลขยางก่อนหน้า(FK FROM tb_history_tire)',
  `spare_parts_stock_id` bigint(20) DEFAULT NULL COMMENT 'รายการอะไหล่(FK FROM tb_spare_parts_stock)',
  `price` decimal(19,4) DEFAULT NULL COMMENT 'ราคา',
  `change_type` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_masteryard`
--

CREATE TABLE `tb_masteryard` (
  `Yard_Id` bigint(20) NOT NULL,
  `Yard_Name` varchar(255) DEFAULT NULL,
  `Yard_Code` varchar(50) NOT NULL,
  `Yard_Type` varchar(50) DEFAULT NULL,
  `Yard_Address` varchar(255) DEFAULT NULL,
  `Yard_Latitude` decimal(10,6) DEFAULT NULL,
  `Yard_Longitude` decimal(10,6) DEFAULT NULL,
  `Yard_Radius` int(10) DEFAULT NULL,
  `Yard_Status` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_master_maintenance_service_cost_type`
--

CREATE TABLE `tb_master_maintenance_service_cost_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_master_preventive_checklist`
--

CREATE TABLE `tb_master_preventive_checklist` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `preventive_mainsystem_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_master_preventive_mainsystem`
--

CREATE TABLE `tb_master_preventive_mainsystem` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_master_preventive_setup`
--

CREATE TABLE `tb_master_preventive_setup` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `fuel_type` varchar(255) DEFAULT NULL,
  `stamp_date` datetime DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_master_preventive_setup_detail`
--

CREATE TABLE `tb_master_preventive_setup_detail` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `preventive_checklist_id` bigint(20) DEFAULT NULL,
  `preventive_setup_item_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_master_preventive_setup_item`
--

CREATE TABLE `tb_master_preventive_setup_item` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `mileage` decimal(19,4) DEFAULT NULL COMMENT 'เลขไมล์ตามแผน',
  `no` int(11) NOT NULL COMMENT '-',
  `remark` mediumtext DEFAULT NULL COMMENT 'หมายเหตุ',
  `status` int(11) NOT NULL COMMENT 'สถานะการใช้งาน',
  `preventive_setup_id` bigint(20) DEFAULT NULL COMMENT 'PreventiveSetupMaster(FK FROM tb_master_preventive_setup)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_master_spare_part_unit`
--

CREATE TABLE `tb_master_spare_part_unit` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_menu`
--

CREATE TABLE `tb_menu` (
  `menu_id` int(11) NOT NULL,
  `list_menu` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tb_move_stock`
--

CREATE TABLE `tb_move_stock` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `qty` decimal(10,2) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `stamp_date` datetime DEFAULT NULL,
  `dep_sps_id` bigint(20) DEFAULT NULL,
  `des_sps_id` bigint(20) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `price` decimal(19,4) DEFAULT NULL,
  `move_stock_pdf_no` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_move_stock_pdf`
--

CREATE TABLE `tb_move_stock_pdf` (
  `move_stock_pdf_no` varchar(50) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `stamp_date` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `yard_dtn_id` bigint(20) DEFAULT NULL,
  `yard_org_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_payment_method`
--

CREATE TABLE `tb_payment_method` (
  `PAYMENT_METHOD_ID` int(11) NOT NULL,
  `PAYMENT_METHOD_NAME` varchar(100) DEFAULT NULL,
  `PAYMENT_METHOD_STATUS` tinyint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_permission`
--

CREATE TABLE `tb_permission` (
  `permission_id` int(11) NOT NULL,
  `id_roles` int(5) DEFAULT 1,
  `id_menu` int(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tb_petty_cash_cost`
--

CREATE TABLE `tb_petty_cash_cost` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `issue_date` datetime DEFAULT NULL,
  `petty_cash_no` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `total_cost_amt` double(22,2) DEFAULT NULL,
  `accounting_id` bigint(20) DEFAULT NULL,
  `driver_id` bigint(20) DEFAULT NULL,
  `expense_id` bigint(20) DEFAULT NULL,
  `expense_detail_id` bigint(20) DEFAULT NULL,
  `truck_tractor_id` bigint(20) DEFAULT NULL,
  `expense_other_detail` text DEFAULT NULL,
  `with_draw` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_petty_cash_master`
--

CREATE TABLE `tb_petty_cash_master` (
  `petty_cash_no` varchar(50) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `issue_date` datetime DEFAULT NULL,
  `petty_cash_status` char(1) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `total_amt` decimal(19,2) DEFAULT NULL,
  `accounting_id` bigint(20) DEFAULT NULL,
  `driver_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `payer_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_preventive`
--

CREATE TABLE `tb_preventive` (
  `code` varchar(50) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `doc_no` varchar(255) DEFAULT NULL,
  `fuel_type` varchar(255) DEFAULT NULL,
  `mileage` decimal(10,4) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `stamp_date` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `sub_sidairy` varchar(255) DEFAULT NULL,
  `yard_id` bigint(20) DEFAULT NULL,
  `driver_id` bigint(20) DEFAULT NULL,
  `master_preventive_setup_item_id` bigint(20) DEFAULT NULL,
  `truck_profile_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_preventive_item`
--

CREATE TABLE `tb_preventive_item` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `status` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `preventive_code` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_preventive_spare_part`
--

CREATE TABLE `tb_preventive_spare_part` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `amount` decimal(19,4) DEFAULT NULL,
  `price` decimal(10,4) DEFAULT NULL,
  `qty` int(11) NOT NULL,
  `remark` text DEFAULT NULL,
  `stamp_date` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `ma_service_type_id` bigint(20) DEFAULT NULL,
  `preventive_code` varchar(50) DEFAULT NULL,
  `spare_parts_stock_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_price_edit_history`
--

CREATE TABLE `tb_price_edit_history` (
  `id` bigint(20) NOT NULL,
  `purchase_order_id` bigint(20) NOT NULL COMMENT 'รหัส Purchase Order ที่แก้ไข',
  `purchase_order_item_id` bigint(20) NOT NULL COMMENT 'รหัส Purchase Order Item ที่แก้ไข',
  `po_no` varchar(50) NOT NULL COMMENT 'เลขที่ PO',
  `item_code` varchar(100) DEFAULT NULL COMMENT 'รหัสสินค้า',
  `item_description` text DEFAULT NULL COMMENT 'รายละเอียดสินค้า',
  `old_unit_price` decimal(15,4) NOT NULL COMMENT 'ราคาต่อหน่วยเดิม',
  `new_unit_price` decimal(15,4) NOT NULL COMMENT 'ราคาต่อหน่วยใหม่',
  `quantity` decimal(15,4) DEFAULT NULL COMMENT 'จำนวน',
  `old_total_amount` decimal(15,2) DEFAULT NULL COMMENT 'จำนวนเงินรวมเดิม',
  `new_total_amount` decimal(15,2) DEFAULT NULL COMMENT 'จำนวนเงินรวมใหม่',
  `edit_reason` text DEFAULT NULL COMMENT 'เหตุผลการแก้ไข',
  `approved_by` bigint(20) DEFAULT NULL COMMENT 'ผู้อนุมัติที่ทำการแก้ไข',
  `approved_by_name` varchar(200) DEFAULT NULL COMMENT 'ชื่อผู้อนุมัติที่ทำการแก้ไข',
  `edit_date` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่และเวลาที่แก้ไข',
  `status` int(11) DEFAULT 1 COMMENT 'สถานะ (1=ใช้งาน, 0=ไม่ใช้งาน)',
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ตารางประวัติการแก้ไขราคาต่อหน่วยใน Purchase Order';

-- --------------------------------------------------------

--
-- Table structure for table `tb_project`
--

CREATE TABLE `tb_project` (
  `PROJECT_ID` bigint(20) NOT NULL COMMENT 'PK',
  `PROJECT_NAME` varchar(100) DEFAULT NULL COMMENT 'Project name',
  `PROJECT_STATUS` tinyint(3) DEFAULT NULL COMMENT 'สถานะการใช้งาน',
  `PROJECT_PAYMENT_CODE` varchar(100) DEFAULT NULL COMMENT '-',
  `PROJECT_AMOUNT` varchar(100) DEFAULT NULL COMMENT '-'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_project_name`
--

CREATE TABLE `tb_project_name` (
  `PROJECT_NAME_ID` int(11) NOT NULL,
  `PROJECT_NAME_NAME` varchar(100) DEFAULT NULL,
  `PROJECT_NAME_STATUS` tinyint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_province`
--

CREATE TABLE `tb_province` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `code` varchar(2) NOT NULL COMMENT 'Code',
  `name_th` varchar(150) NOT NULL COMMENT 'ชื่อภาษาไทย',
  `name_en` varchar(150) NOT NULL COMMENT 'ชื่อภาษาอังกฤษ',
  `geography_id` int(5) NOT NULL DEFAULT 0 COMMENT '-'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='จังหวัด';

-- --------------------------------------------------------

--
-- Table structure for table `tb_purchase_order`
--

CREATE TABLE `tb_purchase_order` (
  `id` bigint(20) NOT NULL,
  `po_no` varchar(50) NOT NULL,
  `po_date` date DEFAULT NULL,
  `requester_id` bigint(20) DEFAULT NULL,
  `requester_name` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `vendor_name` varchar(200) DEFAULT NULL,
  `vendor_address` text DEFAULT NULL,
  `vendor_phone` varchar(50) DEFAULT NULL,
  `vendor_email` varchar(100) DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `payment_term` varchar(200) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `sub_total` decimal(15,2) DEFAULT NULL,
  `withholding_tax_rate` decimal(5,2) DEFAULT NULL,
  `withholding_tax_amount` decimal(15,2) DEFAULT NULL,
  `net_total` decimal(15,2) DEFAULT NULL,
  `approved_by` varchar(50) DEFAULT NULL,
  `approved_date` datetime DEFAULT NULL,
  `rejected_by` bigint(20) DEFAULT NULL,
  `rejected_date` datetime DEFAULT NULL,
  `reject_reason` text DEFAULT NULL,
  `pr_ids` text DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `approver_sign_date` datetime DEFAULT NULL,
  `budget_type` int(11) DEFAULT NULL,
  `checker_sign_date` datetime DEFAULT NULL,
  `delivery_status` int(11) DEFAULT NULL,
  `parking_area` varchar(100) DEFAULT NULL,
  `purchase_purpose` text DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `requester_sign_date` datetime DEFAULT NULL,
  `required_date` datetime DEFAULT NULL,
  `approver_id` bigint(20) DEFAULT NULL,
  `checker_id` bigint(20) DEFAULT NULL,
  `pr_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_purchase_order_item`
--

CREATE TABLE `tb_purchase_order_item` (
  `id` bigint(20) NOT NULL,
  `po_id` bigint(20) NOT NULL,
  `line_no` int(11) DEFAULT NULL,
  `item_code` varchar(100) DEFAULT NULL,
  `item_description` text DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `received_quantity` decimal(15,4) DEFAULT 0.0000,
  `remaining_quantity` decimal(15,4) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `unit_price` decimal(15,4) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `pr_item_id` bigint(20) DEFAULT NULL,
  `pr_no` varchar(50) DEFAULT NULL,
  `item_status` int(11) DEFAULT 1,
  `remarks` text DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `sps_id` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_purchase_requisition`
--

CREATE TABLE `tb_purchase_requisition` (
  `id` bigint(20) NOT NULL,
  `pr_no` varchar(50) NOT NULL,
  `pr_date` date DEFAULT NULL,
  `requester_id` bigint(20) DEFAULT NULL,
  `requester_name` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `expected_date` date DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `sub_total` decimal(15,2) DEFAULT NULL,
  `withholding_tax_rate` decimal(5,2) DEFAULT NULL,
  `withholding_tax_amount` decimal(15,2) DEFAULT NULL,
  `net_total` decimal(15,2) DEFAULT NULL,
  `approved_by` varchar(50) DEFAULT NULL,
  `approved_date` datetime DEFAULT NULL,
  `rejected_by` bigint(20) DEFAULT NULL,
  `rejected_date` datetime DEFAULT NULL,
  `reject_reason` text DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `approver_sign_date` datetime DEFAULT NULL,
  `budget_type` int(11) DEFAULT NULL,
  `checker_sign_date` datetime DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL COMMENT 'Foreign key to tb_stake_holder_master',
  `vendor_name` varchar(200) DEFAULT NULL COMMENT 'ชื่อผู้ขาย',
  `vendor_address` text DEFAULT NULL COMMENT 'ที่อยู่ผู้ขาย',
  `vendor_phone` varchar(50) DEFAULT NULL COMMENT 'โทรศัพท์ผู้ขาย',
  `vendor_email` varchar(100) DEFAULT NULL COMMENT 'อีเมลผู้ขาย',
  `purchase_purpose` text DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `requester_sign_date` datetime DEFAULT NULL,
  `required_date` datetime DEFAULT NULL,
  `approver_id` bigint(20) DEFAULT NULL,
  `checker_id` bigint(20) DEFAULT NULL,
  `yard_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_purchase_requisition_item`
--

CREATE TABLE `tb_purchase_requisition_item` (
  `id` bigint(20) NOT NULL,
  `pr_id` bigint(20) NOT NULL,
  `line_no` int(11) DEFAULT NULL,
  `item_code` varchar(100) DEFAULT NULL,
  `item_description` text DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `unit_price` decimal(15,4) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `remarks` text DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `sps_id` bigint(20) DEFAULT NULL,
  `yard_id` bigint(20) DEFAULT NULL,
  `stock_quantity_at_request` decimal(15,4) DEFAULT NULL COMMENT 'Stock quantity at the time of purchase requisition request'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_purchase_return`
--

CREATE TABLE `tb_purchase_return` (
  `id` bigint(20) NOT NULL,
  `prn_no` varchar(100) NOT NULL,
  `return_date` date DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `return_requester_id` bigint(20) DEFAULT NULL,
  `return_requester_name` varchar(255) DEFAULT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `yard_id` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `vendor_name` varchar(200) DEFAULT NULL,
  `vendor_address` text DEFAULT NULL,
  `vendor_phone` varchar(50) DEFAULT NULL,
  `vendor_email` varchar(100) DEFAULT NULL,
  `expected_return_date` date DEFAULT NULL,
  `return_reason` text DEFAULT NULL,
  `return_type` int(11) DEFAULT NULL COMMENT '1=สินค้าเสียหาย, 2=สินค้าไม่ตรงตามข้อกำหนด, 3=ส่งมาผิด, 4=อื่นๆ',
  `deduction_type` int(11) DEFAULT NULL COMMENT '1=หักเงิน, 2=คืนสินค้า, 3=เปลี่ยนสินค้าใหม่',
  `sub_total` decimal(15,2) DEFAULT 0.00,
  `withholding_tax_rate` decimal(5,2) DEFAULT 0.00,
  `withholding_tax_amount` decimal(15,2) DEFAULT 0.00,
  `net_total` decimal(15,2) DEFAULT 0.00,
  `remarks` text DEFAULT NULL,
  `requester_sign_date` datetime DEFAULT NULL,
  `checker_id` bigint(20) DEFAULT NULL,
  `checker_sign_date` datetime DEFAULT NULL,
  `approver_id` bigint(20) DEFAULT NULL,
  `approver_sign_date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1=Draft, 2=Submitted, 3=Approved, 4=Rejected, 5=Completed',
  `approved_by` varchar(100) DEFAULT NULL,
  `approved_date` datetime DEFAULT NULL,
  `completed_by` varchar(100) DEFAULT NULL,
  `completed_date` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `approver_name` varchar(200) DEFAULT NULL,
  `checker_name` varchar(200) DEFAULT NULL,
  `department_name` varchar(200) DEFAULT NULL,
  `yard_name` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Purchase Return / Return to Supplier / Purchase Return Note (PRN) - ตารางหลักสำหรับการคืนสินค้าให้ผู้ขาย';

-- --------------------------------------------------------

--
-- Table structure for table `tb_purchase_return_item`
--

CREATE TABLE `tb_purchase_return_item` (
  `id` bigint(20) NOT NULL,
  `prn_id` bigint(20) NOT NULL,
  `line_no` int(11) DEFAULT NULL,
  `item_code` varchar(100) DEFAULT NULL,
  `item_name` varchar(200) DEFAULT NULL,
  `item_description` text DEFAULT NULL,
  `original_quantity` decimal(15,4) DEFAULT 0.0000,
  `return_quantity` decimal(15,4) DEFAULT 0.0000,
  `unit` varchar(50) DEFAULT NULL,
  `unit_price` decimal(15,4) DEFAULT 0.0000,
  `total_amount` decimal(15,2) DEFAULT 0.00,
  `return_reason` text DEFAULT NULL,
  `defect_description` text DEFAULT NULL,
  `warranty_claim` tinyint(1) DEFAULT NULL COMMENT 'เป็นการเคลม warranty หรือไม่',
  `status` int(11) DEFAULT NULL COMMENT '1=Pending, 2=Returned, 3=Cancelled',
  `remarks` text DEFAULT NULL,
  `spare_parts_stock_id` bigint(20) DEFAULT NULL,
  `spare_parts_stock_detail_id` bigint(20) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `batch_lot_no` varchar(100) DEFAULT NULL,
  `original_grn_no` varchar(100) DEFAULT NULL,
  `original_po_no` varchar(100) DEFAULT NULL,
  `serial_no` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Purchase Return Items - รายการสินค้าที่คืนให้ผู้ขาย';

-- --------------------------------------------------------

--
-- Table structure for table `tb_quotation`
--

CREATE TABLE `tb_quotation` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `no` varchar(100) DEFAULT NULL COMMENT 'Code',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_stakeholder_master[type=1]',
  `user_id` bigint(20) DEFAULT NULL COMMENT '-',
  `customer_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_stakeholder_master[type=2]',
  `issue_date` datetime DEFAULT NULL COMMENT 'วันที่ออกเอกสาร',
  `status` tinyint(4) DEFAULT NULL COMMENT 'สถานะการใช้งาน',
  `create_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `create_date` datetime DEFAULT NULL COMMENT 'Created date',
  `update_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `update_date` datetime DEFAULT NULL COMMENT 'Updated date'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_quotation_item`
--

CREATE TABLE `tb_quotation_item` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `quotation_id` bigint(20) DEFAULT NULL COMMENT 'Quotation(FK FROM tb_quotation)',
  `route_id` bigint(20) DEFAULT NULL COMMENT 'RouteMaster(FK FROM tb_route_master)',
  `distance` decimal(10,2) DEFAULT NULL COMMENT 'ระยะทาง',
  `truck_type_id` bigint(20) DEFAULT NULL COMMENT 'ประเภทรถ(FK FROM tb_truck_type)',
  `card_id` varchar(100) DEFAULT NULL COMMENT 'บัตรประจำตัว',
  `calculate_type` int(11) DEFAULT NULL COMMENT 'เรทที่ใช้ในการคำนวณ',
  `gasoline_fix_rate` decimal(10,2) DEFAULT NULL COMMENT 'ราคาของเรทคงที่',
  `gasoline_fix_unit` varchar(100) DEFAULT NULL COMMENT 'หน่วยของเรทคงที่',
  `create_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `create_date` datetime DEFAULT NULL COMMENT 'Created date',
  `update_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `update_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `status` tinyint(4) DEFAULT NULL COMMENT 'สถานะการใช้งาน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_quotation_rate`
--

CREATE TABLE `tb_quotation_rate` (
  `id` bigint(20) NOT NULL,
  `quotation__item_id` bigint(20) DEFAULT NULL,
  `start` decimal(10,2) DEFAULT NULL,
  `end` decimal(10,2) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `create_by` varchar(100) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_by` varchar(100) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `quotation_item_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_receipt_item_ia`
--

CREATE TABLE `tb_receipt_item_ia` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `issue_date` datetime DEFAULT NULL,
  `receipt_ia_no` varchar(255) DEFAULT NULL,
  `total_receipt_ia_amt` decimal(19,2) DEFAULT NULL,
  `receipt_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_receipt_master`
--

CREATE TABLE `tb_receipt_master` (
  `receipt_no` varchar(50) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `issue_date` datetime DEFAULT NULL,
  `receipt_status` char(1) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `total_receipt_amt` decimal(19,2) DEFAULT NULL,
  `job_type_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_receipt_ra_master`
--

CREATE TABLE `tb_receipt_ra_master` (
  `receipt_ra_no` varchar(50) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `issue_date` datetime DEFAULT NULL,
  `receipt_ra_status` char(1) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `total_receipt_ra_amt` decimal(19,2) DEFAULT NULL,
  `job_type_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_role`
--

CREATE TABLE `tb_role` (
  `role_id` int(11) NOT NULL,
  `role_code` varchar(15) DEFAULT NULL,
  `can_add` tinyint(1) DEFAULT NULL,
  `can_edit` tinyint(1) DEFAULT NULL,
  `can_view` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_roles`
--

CREATE TABLE `tb_roles` (
  `roleId` int(11) NOT NULL,
  `role_n` varchar(10) DEFAULT NULL,
  `role_c` varchar(10) DEFAULT NULL,
  `status` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `tb_route_detail`
--

CREATE TABLE `tb_route_detail` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `route_id` bigint(20) DEFAULT NULL COMMENT 'RouteMaster(FK FROM tb_route_master)',
  `service_type` varchar(255) DEFAULT NULL COMMENT 'ประเภทขนส่ง',
  `transport_type` varchar(100) DEFAULT NULL COMMENT '-',
  `set_schedule` datetime DEFAULT NULL COMMENT 'กำหนดเวลา',
  `gsdb_id` bigint(20) DEFAULT NULL COMMENT 'รหัสสถานี(FK FROM tb_gsdb_code)',
  `status` int(11) DEFAULT NULL COMMENT 'สถานะการใช้งาน',
  `create_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `create_date` datetime DEFAULT NULL COMMENT 'Created date',
  `update_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `update_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `tailer` int(1) DEFAULT 0,
  `truck_tractor_id` bigint(20) DEFAULT 0,
  `truck_trailer_id` bigint(20) DEFAULT 0,
  `driver_id` bigint(20) DEFAULT 0,
  `gsdb_id2` bigint(20) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_route_master`
--

CREATE TABLE `tb_route_master` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `route_no` varchar(100) NOT NULL COMMENT 'Route no',
  `route_name` varchar(255) NOT NULL COMMENT 'Name',
  `ref_doc_no` varchar(100) NOT NULL COMMENT 'Doc no',
  `project_id` bigint(20) DEFAULT NULL COMMENT 'Project(FK FROM tb_project)',
  `job_type_id` bigint(20) DEFAULT NULL COMMENT 'ประเภทงาน(FK FROM tb_job_type)',
  `customer_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM  tb_stake_holder_master[Type=2]',
  `pickup_location_id` int(11) DEFAULT NULL COMMENT 'FK FROM tb_gsdb_code',
  `delivery_location_id` int(11) DEFAULT NULL COMMENT 'FK FROM tb_gsdb_code',
  `return_location_id` int(11) DEFAULT NULL COMMENT 'FK FROM tb_gsdb_code',
  `unit_rate_4w` decimal(10,2) DEFAULT NULL COMMENT 'Units rate 4W',
  `unit_rate_6w_5m` decimal(10,2) DEFAULT NULL COMMENT 'Unit Rate(6W-5M)',
  `unit_rate_6w_7m` decimal(10,2) DEFAULT NULL COMMENT 'Units rate 6W(7M)',
  `unit_rate_10w` decimal(10,2) DEFAULT NULL COMMENT 'Units rate 10W',
  `unit_rate_18w` decimal(10,2) DEFAULT NULL COMMENT 'Units rate 18W',
  `allowance_rate` decimal(10,2) DEFAULT NULL COMMENT 'เบี้ยเลี้ยง',
  `coordinate_car_rate` decimal(10,2) DEFAULT NULL COMMENT 'จ่ายรถร่วม',
  `distance_set` decimal(10,2) DEFAULT NULL COMMENT 'ระยะทางที่กำหนด',
  `route_truck_type_no` varchar(100) DEFAULT NULL COMMENT '-',
  `route_detail_no` varchar(100) DEFAULT NULL COMMENT '-',
  `route_status` tinyint(4) DEFAULT NULL COMMENT 'สถานะการใช้งาน',
  `create_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `create_date` datetime DEFAULT NULL COMMENT 'Created date',
  `update_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `update_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `distance_band` varchar(255) DEFAULT NULL COMMENT 'Distance band'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_route_truck_cost`
--

CREATE TABLE `tb_route_truck_cost` (
  `id` bigint(20) NOT NULL COMMENT 'PK',
  `route_truck_type_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_route_truck_type',
  `truck_cost_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_cost',
  `truck_cost_detail_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_truck_cost_detail',
  `qty` int(11) DEFAULT NULL COMMENT 'Quantity',
  `amount_unit` decimal(10,2) DEFAULT NULL COMMENT 'Unit price',
  `amount` decimal(10,2) DEFAULT NULL COMMENT 'Total price',
  `account_group` varchar(50) DEFAULT NULL COMMENT 'Account Group',
  `bill_available` int(11) DEFAULT NULL COMMENT '-',
  `status` int(11) DEFAULT NULL COMMENT 'status',
  `route_detail_id` bigint(20) DEFAULT NULL,
  `route_id` bigint(20) DEFAULT NULL,
  `trailer` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_route_truck_type`
--

CREATE TABLE `tb_route_truck_type` (
  `id` bigint(20) NOT NULL,
  `route_id` bigint(20) DEFAULT NULL COMMENT 'RouteMaster(FK FROM tb_route_master)',
  `truck_type_id` bigint(20) DEFAULT NULL COMMENT 'ประเภทรถ(FK FROM tb_truck_type)',
  `truck_rate` decimal(10,2) DEFAULT NULL COMMENT 'ราคา',
  `truck_rate_unit` varchar(100) DEFAULT NULL COMMENT 'หน่วย ',
  `status` int(11) DEFAULT NULL COMMENT 'สถานะการใช้งาน',
  `cretate_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `create_date` datetime DEFAULT NULL COMMENT 'Created date',
  `update_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `update_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `truck_type` varchar(100) DEFAULT NULL COMMENT '-'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_running_no`
--

CREATE TABLE `tb_running_no` (
  `type` varchar(50) NOT NULL,
  `year` varchar(4) NOT NULL,
  `month` varchar(2) NOT NULL,
  `running_no` bigint(20) DEFAULT NULL COMMENT 'Current running number value (must be >= 1) - automatically incremented'
) ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_running_no_day`
--

CREATE TABLE `tb_running_no_day` (
  `day` varchar(2) NOT NULL,
  `month` varchar(2) NOT NULL,
  `type` varchar(20) NOT NULL,
  `year` varchar(4) NOT NULL,
  `running_no` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_safety`
--

CREATE TABLE `tb_safety` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `accident_date` datetime DEFAULT NULL,
  `accident_detail` text DEFAULT NULL COMMENT 'อธิบายรายละเอียดการเกิดเหตุ',
  `accident_type_detail` varchar(255) DEFAULT NULL COMMENT 'ระบุลักษณะการเกิดเหตุ',
  `car_insurance_doc_no` varchar(255) DEFAULT NULL COMMENT 'เลขที่เอกสารใบแจ้งเคลมประกันรถยนต์',
  `claim` decimal(19,4) DEFAULT NULL COMMENT 'ประกันจ่ายชดเชยให้เป็นมูลค่า',
  `closed_by` varchar(100) DEFAULT NULL,
  `closed_date` datetime DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `completion_date` datetime DEFAULT NULL,
  `date_of_receipt` datetime DEFAULT NULL COMMENT 'วันที่รับเงิน',
  `employee_responsibility_value` decimal(19,4) DEFAULT NULL COMMENT 'พนักงานรับผิดชอบเป็นมูลค่า',
  `goods_damaged` int(11) DEFAULT NULL COMMENT 'กรณีที่ชิ้นงานเกิดความเสียหาย',
  `goods_damaged_company` varchar(255) DEFAULT NULL COMMENT 'สินค้าที่เสียหายเป็นของบริษัท',
  `goods_damaged_price` decimal(19,4) DEFAULT NULL COMMENT 'ราคาที่ลูกค้าเรียกเก็บ',
  `goods_damaged_remark` varchar(255) DEFAULT NULL COMMENT 'หมายเหตุของสินค้าเสียหาย',
  `injured` int(11) DEFAULT NULL COMMENT 'กรณีมีผู้ได้รับบาดเจ็บ',
  `litigant_name` varchar(255) DEFAULT NULL COMMENT 'ชื่อคู่กรณี',
  `litigant_tel` varchar(255) DEFAULT NULL COMMENT 'เบอร์โทรติดต่อคู่กรณี',
  `manual_data` char(1) DEFAULT NULL,
  `place_of_accident` text DEFAULT NULL,
  `product_insurance_doc_no` varchar(255) DEFAULT NULL COMMENT 'เลขที่เอกสารใบแจ้งเคลมประกันสินค้า',
  `rca_analysis_by` varchar(255) DEFAULT NULL COMMENT 'AnalysisBy',
  `rca_environment` varchar(255) DEFAULT NULL COMMENT 'Environment',
  `rca_information` varchar(255) DEFAULT NULL COMMENT 'Information',
  `rca_machine` varchar(255) DEFAULT NULL COMMENT 'Machine',
  `rca_man` varchar(255) DEFAULT NULL COMMENT 'Man',
  `rca_method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `remark` varchar(255) DEFAULT NULL COMMENT 'หมายเหตุ',
  `repair_cost` decimal(19,4) DEFAULT NULL COMMENT 'มูลค่าซ่อม',
  `repair_date` datetime DEFAULT NULL,
  `reserve_payment_company` decimal(19,4) DEFAULT NULL COMMENT 'บริษัทสำรองจ่าย',
  `stamp_date` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `track_status` varchar(255) DEFAULT NULL,
  `type` varchar(5) DEFAULT NULL,
  `accident_area_type_id` bigint(20) DEFAULT NULL,
  `accident_type_id` bigint(20) DEFAULT NULL,
  `car_ins_broker_id` bigint(20) DEFAULT NULL,
  `driver_id` bigint(20) DEFAULT NULL,
  `fault_acident_type_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `ma_id` bigint(20) DEFAULT NULL,
  `product_ins_broker_id` bigint(20) DEFAULT NULL,
  `truck_profile_id` bigint(20) DEFAULT NULL,
  `injured_person_name` varchar(255) DEFAULT NULL COMMENT 'ชื่อผู้เสียหาย',
  `injured_person_tel` varchar(100) DEFAULT NULL COMMENT 'เบอรืโทรติดต่อผู้เสียหาย',
  `recoup` decimal(19,4) DEFAULT NULL COMMENT 'การชดใช้',
  `survey_name` varchar(255) DEFAULT NULL COMMENT 'ชื่อคู่กรณี',
  `survey_tel` varchar(100) DEFAULT NULL COMMENT 'เบอร์โทรติดต่อคู่กรณี',
  `taken_to_hospital` varchar(255) DEFAULT NULL COMMENT 'นำส่งรพ',
  `manager_id` bigint(20) DEFAULT NULL,
  `resolve_rca_environment` text DEFAULT NULL COMMENT 'resolve Environment',
  `resolve_rca_machine` text DEFAULT NULL COMMENT 'resolve Machine',
  `resolve_rca_man` text DEFAULT NULL COMMENT 'resolve Man',
  `resolve_rca_material` text DEFAULT NULL COMMENT 'resolve Material',
  `resolve_rca_method` text DEFAULT NULL COMMENT 'resolve Method',
  `car_ins_company_id` bigint(20) DEFAULT NULL,
  `product_ins_company_id` bigint(20) DEFAULT NULL,
  `by_supervisor` tinyint(1) DEFAULT 0,
  `by_related_person` tinyint(1) DEFAULT 0,
  `by_safety_officer` tinyint(1) DEFAULT 0,
  `by_others` tinyint(1) DEFAULT 0,
  `act_without_permission` tinyint(1) DEFAULT 0 COMMENT 'ปฏิบัติงานโดยไม่ได้รับอนุญาติ',
  `act_unsafe_posture` tinyint(1) DEFAULT 0 COMMENT 'การจัดวางท่าทางการปฏิบัติงานที่ไม่ปลอดภัย',
  `act_wrong_procedure` tinyint(1) DEFAULT 0 COMMENT 'ปฏิบัติงานผิดขั้นตอน',
  `act_improper_lifting` tinyint(1) DEFAULT 0 COMMENT 'ยกเคลื่อนย้ายไม่ถูกต้อง',
  `act_no_ppe` tinyint(1) DEFAULT 0 COMMENT 'ไม่สวม PPE',
  `act_wrong_ppe` tinyint(1) DEFAULT 0 COMMENT 'ใช้ PPE ไม่ถูกต้อง',
  `act_no_tool` tinyint(1) DEFAULT 0 COMMENT 'ไม่ใช้เครื่องมือที่กำหนด',
  `act_wrong_tool_use` tinyint(1) DEFAULT 0 COMMENT 'ใช้เครื่องมือไม่ถูกวิธี',
  `act_playing` tinyint(1) DEFAULT 0 COMMENT 'เล่นหยอกล้อ',
  `act_inattention` tinyint(1) DEFAULT 0 COMMENT 'ไม่เอาใจใส่ในงาน',
  `act_daydream` tinyint(1) DEFAULT 0 COMMENT 'พลั้งเผลอเหม่อลอย',
  `act_violate_rules` tinyint(1) DEFAULT 0 COMMENT 'ไม่ปฏิบัติตามกฎ',
  `act_wrong_dress` tinyint(1) DEFAULT 0 COMMENT 'แต่งกายไม่เหมาะสม',
  `act_unfit` tinyint(1) DEFAULT 0 COMMENT 'สภาพร่างกาย/จิตใจไม่พร้อม',
  `act_bad_attitude` tinyint(1) DEFAULT 0 COMMENT 'ทัศนคติไม่ถูกต้อง',
  `act_other` tinyint(1) DEFAULT 0 COMMENT 'อื่นๆ (ระบุ)',
  `act_othertxt` text DEFAULT NULL COMMENT 'อื่นๆ (ระบุ)',
  `cond_machine_damage` tinyint(1) DEFAULT 0 COMMENT 'เครื่องจักร/เครื่องมือชำรุด',
  `cond_electric_fault` tinyint(1) DEFAULT 0 COMMENT 'ระบบไฟฟ้าชำรุด',
  `cond_material_messy` tinyint(1) DEFAULT 0 COMMENT 'วัสดุวางไม่เป็นระเบียบ',
  `cond_unsafe_method` tinyint(1) DEFAULT 0 COMMENT 'วิธีการทำงานไม่ปลอดภัย',
  `cond_limited_space` tinyint(1) DEFAULT 0 COMMENT 'สถานที่คับแคบ',
  `cond_no_training` tinyint(1) DEFAULT 0 COMMENT 'ขาดการอบรม',
  `cond_no_ppe` tinyint(1) DEFAULT 0 COMMENT 'ขาด PPE',
  `cond_no_guard` tinyint(1) DEFAULT 0 COMMENT 'ขาดอุปกรณ์ป้องกันส่วนเคลื่อนไหว',
  `cond_unsafe_environment` tinyint(1) DEFAULT 0 COMMENT 'แสง/เสียง/ความร้อนไม่ปลอดภัย',
  `cond_no_alarm` tinyint(1) DEFAULT 0 COMMENT 'สัญญาณเตือนไม่เพียงพอ',
  `cond_other` tinyint(1) DEFAULT 0 COMMENT 'อื่นๆ (ระบุ)',
  `cond_othertxt` text DEFAULT NULL COMMENT 'อื่นๆ (ระบุ)',
  `act_detail` text DEFAULT NULL,
  `condition_detail` text DEFAULT NULL,
  `corrective_action_1` varchar(255) DEFAULT NULL,
  `corrective_action_1_due` varchar(120) DEFAULT NULL,
  `corrective_action_1_responsible` varchar(100) DEFAULT NULL,
  `corrective_action_2` varchar(255) DEFAULT NULL,
  `corrective_action_2_due` varchar(120) DEFAULT NULL,
  `corrective_action_2_responsible` varchar(100) DEFAULT NULL,
  `corrective_action_3` varchar(255) DEFAULT NULL,
  `corrective_action_3_due` varchar(120) DEFAULT NULL,
  `corrective_action_3_responsible` varchar(100) DEFAULT NULL,
  `preventive_action_1` varchar(255) DEFAULT NULL,
  `preventive_action_1_due` varchar(120) DEFAULT NULL,
  `preventive_action_1_responsible` varchar(100) DEFAULT NULL,
  `preventive_action_2` varchar(255) DEFAULT NULL,
  `preventive_action_2_due` varchar(120) DEFAULT NULL,
  `preventive_action_2_responsible` varchar(100) DEFAULT NULL,
  `preventive_action_3` varchar(255) DEFAULT NULL,
  `preventive_action_3_due` varchar(120) DEFAULT NULL,
  `preventive_action_3_responsible` varchar(100) DEFAULT NULL,
  `safety_officer_suggestion_1` varchar(255) DEFAULT NULL,
  `safety_officer_suggestion_2` varchar(255) DEFAULT NULL,
  `safety_officer_suggestion_3` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_safety2021_2023`
--

CREATE TABLE `tb_safety2021_2023` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `accident_date` datetime DEFAULT NULL,
  `accident_detail` text DEFAULT NULL COMMENT 'อธิบายรายละเอียดการเกิดเหตุ',
  `accident_type_detail` varchar(255) DEFAULT NULL COMMENT 'ระบุลักษณะการเกิดเหตุ',
  `car_insurance_doc_no` varchar(255) DEFAULT NULL COMMENT 'เลขที่เอกสารใบแจ้งเคลมประกันรถยนต์',
  `claim` decimal(19,4) DEFAULT NULL COMMENT 'ประกันจ่ายชดเชยให้เป็นมูลค่า',
  `closed_by` varchar(100) DEFAULT NULL,
  `closed_date` datetime DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `completion_date` datetime DEFAULT NULL,
  `date_of_receipt` datetime DEFAULT NULL COMMENT 'วันที่รับเงิน',
  `employee_responsibility_value` decimal(19,4) DEFAULT NULL COMMENT 'พนักงานรับผิดชอบเป็นมูลค่า',
  `goods_damaged` int(11) DEFAULT NULL COMMENT 'กรณีที่ชิ้นงานเกิดความเสียหาย',
  `goods_damaged_company` varchar(255) DEFAULT NULL COMMENT 'สินค้าที่เสียหายเป็นของบริษัท',
  `goods_damaged_price` decimal(19,4) DEFAULT NULL COMMENT 'ราคาที่ลูกค้าเรียกเก็บ',
  `goods_damaged_remark` varchar(255) DEFAULT NULL COMMENT 'หมายเหตุของสินค้าเสียหาย',
  `injured` int(11) DEFAULT NULL COMMENT 'กรณีมีผู้ได้รับบาดเจ็บ',
  `litigant_name` varchar(255) DEFAULT NULL COMMENT 'ชื่อคู่กรณี',
  `litigant_tel` varchar(255) DEFAULT NULL COMMENT 'เบอร์โทรติดต่อคู่กรณี',
  `manual_data` char(1) DEFAULT NULL,
  `place_of_accident` text DEFAULT NULL,
  `product_insurance_doc_no` varchar(255) DEFAULT NULL COMMENT 'เลขที่เอกสารใบแจ้งเคลมประกันสินค้า',
  `rca_analysis_by` varchar(255) DEFAULT NULL COMMENT 'AnalysisBy',
  `rca_environment` varchar(255) DEFAULT NULL COMMENT 'Environment',
  `rca_information` varchar(255) DEFAULT NULL COMMENT 'Information',
  `rca_machine` varchar(255) DEFAULT NULL COMMENT 'Machine',
  `rca_man` varchar(255) DEFAULT NULL COMMENT 'Man',
  `rca_method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `remark` varchar(255) DEFAULT NULL COMMENT 'หมายเหตุ',
  `repair_cost` decimal(19,4) DEFAULT NULL COMMENT 'มูลค่าซ่อม',
  `repair_date` datetime DEFAULT NULL,
  `reserve_payment_company` decimal(19,4) DEFAULT NULL COMMENT 'บริษัทสำรองจ่าย',
  `stamp_date` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `track_status` varchar(255) DEFAULT NULL,
  `type` varchar(5) DEFAULT NULL,
  `accident_area_type_id` bigint(20) DEFAULT NULL,
  `accident_type_id` bigint(20) DEFAULT NULL,
  `car_ins_broker_id` bigint(20) DEFAULT NULL,
  `driver_id` bigint(20) DEFAULT NULL,
  `fault_acident_type_id` bigint(20) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `ma_id` bigint(20) DEFAULT NULL,
  `product_ins_broker_id` bigint(20) DEFAULT NULL,
  `truck_profile_id` bigint(20) DEFAULT NULL,
  `injured_person_name` varchar(255) DEFAULT NULL COMMENT 'ชื่อผู้เสียหาย',
  `injured_person_tel` varchar(100) DEFAULT NULL COMMENT 'เบอรืโทรติดต่อผู้เสียหาย',
  `recoup` decimal(19,4) DEFAULT NULL COMMENT 'การชดใช้',
  `survey_name` varchar(255) DEFAULT NULL COMMENT 'ชื่อคู่กรณี',
  `survey_tel` varchar(100) DEFAULT NULL COMMENT 'เบอร์โทรติดต่อคู่กรณี',
  `taken_to_hospital` varchar(255) DEFAULT NULL COMMENT 'นำส่งรพ',
  `manager_id` bigint(20) DEFAULT NULL,
  `resolve_rca_environment` text DEFAULT NULL COMMENT 'resolve Environment',
  `resolve_rca_machine` text DEFAULT NULL COMMENT 'resolve Machine',
  `resolve_rca_man` text DEFAULT NULL COMMENT 'resolve Man',
  `resolve_rca_material` text DEFAULT NULL COMMENT 'resolve Material',
  `resolve_rca_method` text DEFAULT NULL COMMENT 'resolve Method',
  `car_ins_company_id` bigint(20) DEFAULT NULL,
  `product_ins_company_id` bigint(20) DEFAULT NULL,
  `by_supervisor` tinyint(1) DEFAULT 0,
  `by_related_person` tinyint(1) DEFAULT 0,
  `by_safety_officer` tinyint(1) DEFAULT 0,
  `by_others` tinyint(1) DEFAULT 0,
  `act_without_permission` tinyint(1) DEFAULT 0 COMMENT 'ปฏิบัติงานโดยไม่ได้รับอนุญาติ',
  `act_unsafe_posture` tinyint(1) DEFAULT 0 COMMENT 'การจัดวางท่าทางการปฏิบัติงานที่ไม่ปลอดภัย',
  `act_wrong_procedure` tinyint(1) DEFAULT 0 COMMENT 'ปฏิบัติงานผิดขั้นตอน',
  `act_improper_lifting` tinyint(1) DEFAULT 0 COMMENT 'ยกเคลื่อนย้ายไม่ถูกต้อง',
  `act_no_ppe` tinyint(1) DEFAULT 0 COMMENT 'ไม่สวม PPE',
  `act_wrong_ppe` tinyint(1) DEFAULT 0 COMMENT 'ใช้ PPE ไม่ถูกต้อง',
  `act_no_tool` tinyint(1) DEFAULT 0 COMMENT 'ไม่ใช้เครื่องมือที่กำหนด',
  `act_wrong_tool_use` tinyint(1) DEFAULT 0 COMMENT 'ใช้เครื่องมือไม่ถูกวิธี',
  `act_playing` tinyint(1) DEFAULT 0 COMMENT 'เล่นหยอกล้อ',
  `act_inattention` tinyint(1) DEFAULT 0 COMMENT 'ไม่เอาใจใส่ในงาน',
  `act_daydream` tinyint(1) DEFAULT 0 COMMENT 'พลั้งเผลอเหม่อลอย',
  `act_violate_rules` tinyint(1) DEFAULT 0 COMMENT 'ไม่ปฏิบัติตามกฎ',
  `act_wrong_dress` tinyint(1) DEFAULT 0 COMMENT 'แต่งกายไม่เหมาะสม',
  `act_unfit` tinyint(1) DEFAULT 0 COMMENT 'สภาพร่างกาย/จิตใจไม่พร้อม',
  `act_bad_attitude` tinyint(1) DEFAULT 0 COMMENT 'ทัศนคติไม่ถูกต้อง',
  `act_other` tinyint(1) DEFAULT 0 COMMENT 'อื่นๆ (ระบุ)',
  `act_othertxt` text DEFAULT NULL COMMENT 'อื่นๆ (ระบุ)',
  `cond_machine_damage` tinyint(1) DEFAULT 0 COMMENT 'เครื่องจักร/เครื่องมือชำรุด',
  `cond_electric_fault` tinyint(1) DEFAULT 0 COMMENT 'ระบบไฟฟ้าชำรุด',
  `cond_material_messy` tinyint(1) DEFAULT 0 COMMENT 'วัสดุวางไม่เป็นระเบียบ',
  `cond_unsafe_method` tinyint(1) DEFAULT 0 COMMENT 'วิธีการทำงานไม่ปลอดภัย',
  `cond_limited_space` tinyint(1) DEFAULT 0 COMMENT 'สถานที่คับแคบ',
  `cond_no_training` tinyint(1) DEFAULT 0 COMMENT 'ขาดการอบรม',
  `cond_no_ppe` tinyint(1) DEFAULT 0 COMMENT 'ขาด PPE',
  `cond_no_guard` tinyint(1) DEFAULT 0 COMMENT 'ขาดอุปกรณ์ป้องกันส่วนเคลื่อนไหว',
  `cond_unsafe_environment` tinyint(1) DEFAULT 0 COMMENT 'แสง/เสียง/ความร้อนไม่ปลอดภัย',
  `cond_no_alarm` tinyint(1) DEFAULT 0 COMMENT 'สัญญาณเตือนไม่เพียงพอ',
  `cond_other` tinyint(1) DEFAULT 0 COMMENT 'อื่นๆ (ระบุ)',
  `cond_othertxt` text DEFAULT NULL COMMENT 'อื่นๆ (ระบุ)',
  `act_detail` text DEFAULT NULL,
  `condition_detail` text DEFAULT NULL,
  `corrective_action_1` varchar(255) DEFAULT NULL,
  `corrective_action_1_due` varchar(120) DEFAULT NULL,
  `corrective_action_1_responsible` varchar(100) DEFAULT NULL,
  `corrective_action_2` varchar(255) DEFAULT NULL,
  `corrective_action_2_due` varchar(120) DEFAULT NULL,
  `corrective_action_2_responsible` varchar(100) DEFAULT NULL,
  `corrective_action_3` varchar(255) DEFAULT NULL,
  `corrective_action_3_due` varchar(120) DEFAULT NULL,
  `corrective_action_3_responsible` varchar(100) DEFAULT NULL,
  `preventive_action_1` varchar(255) DEFAULT NULL,
  `preventive_action_1_due` varchar(120) DEFAULT NULL,
  `preventive_action_1_responsible` varchar(100) DEFAULT NULL,
  `preventive_action_2` varchar(255) DEFAULT NULL,
  `preventive_action_2_due` varchar(120) DEFAULT NULL,
  `preventive_action_2_responsible` varchar(100) DEFAULT NULL,
  `preventive_action_3` varchar(255) DEFAULT NULL,
  `preventive_action_3_due` varchar(120) DEFAULT NULL,
  `preventive_action_3_responsible` varchar(100) DEFAULT NULL,
  `safety_officer_suggestion_1` varchar(255) DEFAULT NULL,
  `safety_officer_suggestion_2` varchar(255) DEFAULT NULL,
  `safety_officer_suggestion_3` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_safety_attachment`
--

CREATE TABLE `tb_safety_attachment` (
  `attachment_no` varchar(30) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `attachment_name` varchar(255) DEFAULT NULL,
  `attachment_remark` text DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `thumbnail` text DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `safety_id` bigint(20) NOT NULL,
  `safety_attachment_type_id` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_safety_attachment2021_2023`
--

CREATE TABLE `tb_safety_attachment2021_2023` (
  `attachment_no` varchar(30) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `attachment_name` varchar(255) DEFAULT NULL,
  `attachment_remark` text DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `thumbnail` text DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `safety_id` bigint(20) NOT NULL,
  `safety_attachment_type_id` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_safety_attachment_type`
--

CREATE TABLE `tb_safety_attachment_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `type` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_sale_type`
--

CREATE TABLE `tb_sale_type` (
  `SALE_TYPE_ID` bigint(20) NOT NULL COMMENT 'PK',
  `SALE_TYPE_NAME` varchar(80) DEFAULT NULL COMMENT 'ชื่อประเภทผู้ขาย',
  `SALE_TYPE_STATUS` tinyint(3) DEFAULT NULL COMMENT 'สถานะการใช้งาน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ประเภทผู้ขาย';

-- --------------------------------------------------------

--
-- Table structure for table `tb_setstopeta`
--

CREATE TABLE `tb_setstopeta` (
  `id` int(11) NOT NULL,
  `loadStopID` int(11) NOT NULL,
  `movementDateTime` datetime NOT NULL,
  `estimatedDateTime` datetime NOT NULL,
  `latitude` decimal(10,6) NOT NULL,
  `longitude` decimal(10,6) NOT NULL,
  `completedFlag` varchar(10) NOT NULL,
  `errorMessage` text DEFAULT NULL,
  `lastUpdateDate` datetime DEFAULT NULL,
  `lastUpdateUser` varchar(20) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `setStopremark` varchar(255) DEFAULT NULL,
  `statusSetStop` varchar(20) DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_sl_service_ctrl`
--

CREATE TABLE `tb_sl_service_ctrl` (
  `Id` int(11) NOT NULL,
  `loadID` bigint(20) NOT NULL DEFAULT 0,
  `token` varchar(1000) NOT NULL DEFAULT '',
  `activeDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_spare_parts`
--

CREATE TABLE `tb_spare_parts` (
  `id` bigint(20) NOT NULL,
  `spare_parts_type_id` bigint(20) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_spare_parts_stock`
--

CREATE TABLE `tb_spare_parts_stock` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `amount_unit` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `max_qty` double DEFAULT NULL,
  `min_qty` double DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `ref_doc_no` varchar(255) DEFAULT NULL,
  `stamp_date` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `yard_id` bigint(20) DEFAULT NULL,
  `spare_parts_id` bigint(20) DEFAULT NULL,
  `spare_parts_type_id` bigint(20) DEFAULT NULL,
  `master_spare_part_unit_id` bigint(20) DEFAULT NULL,
  `parent_code` varchar(100) DEFAULT NULL,
  `parent_id` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_spare_parts_stock_detail`
--

CREATE TABLE `tb_spare_parts_stock_detail` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `price` decimal(10,4) DEFAULT NULL,
  `qty` decimal(10,2) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `stamp_date` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `withdraw_qty` decimal(10,2) DEFAULT NULL,
  `spare_parts_stock_id` bigint(20) DEFAULT NULL,
  `flag` char(1) DEFAULT NULL,
  `move_stock_id` bigint(20) DEFAULT NULL,
  `po_no` varchar(255) DEFAULT NULL,
  `grn_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_spare_parts_type`
--

CREATE TABLE `tb_spare_parts_type` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_sr_master`
--

CREATE TABLE `tb_sr_master` (
  `sr_no` varchar(50) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `amont_sr` decimal(19,2) DEFAULT NULL,
  `amont_vat` decimal(19,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `issue_date` datetime DEFAULT NULL,
  `ref_no` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `sr_status` char(1) DEFAULT NULL,
  `sr_type` varchar(2) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `vat` double(22,2) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `ref_inv_no` varchar(255) DEFAULT NULL,
  `receipt_no` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_stake_holder_attachment`
--

CREATE TABLE `tb_stake_holder_attachment` (
  `attachment_no` varchar(30) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `attachment_name` varchar(255) DEFAULT NULL,
  `attachment_remark` text DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `thumbnail` text DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `stake_holder_id` bigint(20) NOT NULL,
  `stake_holder_attachment_type_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_stake_holder_master`
--

CREATE TABLE `tb_stake_holder_master` (
  `STAKE_HOLDER_UN_ID` bigint(20) NOT NULL COMMENT 'PK',
  `STAKE_HOLDER_ID` varchar(150) DEFAULT NULL COMMENT 'Code',
  `STAKE_HOLDER_NAME` varchar(150) DEFAULT NULL COMMENT 'ชื่อ',
  `STAKE_HOLDER_ADDRESS` varchar(150) DEFAULT NULL COMMENT 'ที่อยู่',
  `STAKE_HOLDER_SUBDISTRICT` varchar(150) DEFAULT NULL COMMENT 'ตำบล',
  `STAKE_HOLDER_DISTRICT` varchar(150) DEFAULT NULL COMMENT 'อำเภอ',
  `STAKE_HOLDER_PROVINCE` varchar(150) DEFAULT NULL COMMENT 'จังหวัด',
  `STAKE_HOLDER_POST_CODE` varchar(150) DEFAULT NULL COMMENT 'รหัสไปรษณีย์',
  `STAKE_HOLDER_TEL_NO` varchar(150) DEFAULT NULL COMMENT 'เบอร์โทรศัพท์',
  `STAKE_HOLDER_FAX_NO` varchar(150) DEFAULT NULL COMMENT 'แฟกซ์',
  `STAKE_HOLDER_MOBILE_NO` varchar(150) DEFAULT NULL COMMENT 'เบอร์โทรศัพท์มือถือ',
  `STAKE_HOLDER_EMAIL` varchar(80) DEFAULT NULL COMMENT 'อีเมล',
  `STAKE_HOLDER_CONTACT_NAME` varchar(80) DEFAULT NULL COMMENT 'ชื่อผู้ติดต่อ',
  `STAKE_HOLDER_TAX_NO` varchar(80) DEFAULT NULL COMMENT 'เลขประจำตัวผู้เสียภาษี',
  `STAKE_HOLDER_SALE_TYPE` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_sale_type',
  `STAKE_HOLDER_PAYMENT_CONDITION` varchar(80) DEFAULT NULL COMMENT '-',
  `STAKE_HOLDER_PAYMENT_METHOD` int(11) DEFAULT NULL COMMENT 'ประเภทการชำระเงิน',
  `STAKE_HOLDER_REF_BANK` varchar(50) DEFAULT NULL COMMENT 'บัญชีธนาคาร (โอนเงิน)',
  `STAKE_HOLDER_REF_BANK_BRANCH` varchar(50) DEFAULT NULL COMMENT 'สาขาธนาคาร',
  `STAKE_HOLDER_REF_ACCOUNT_NO` varchar(80) DEFAULT NULL COMMENT 'เลขที่บัญชี (โอนเงิน)',
  `STAKE_HOLDER_REF_ACCOUNT_NAME` varchar(80) DEFAULT NULL COMMENT 'ชื่อบัญชี (โอนเงิน)',
  `STAKE_HOLDER_PROJECT` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_project',
  `STAKE_HOLDER_CREDIT_TERM` int(11) DEFAULT NULL COMMENT 'FK FROM tb_credit_term',
  `STAKE_HOLDER_TYPE` int(11) DEFAULT NULL COMMENT '1 is individual, 2 is coperate',
  `STAKE_HOLDER_STATUS` tinyint(1) DEFAULT NULL COMMENT 'สถานะ',
  `STAKE_HOLDER_CREATE_DATE` datetime DEFAULT NULL COMMENT 'Created by user',
  `STAKE_HOLDER_CREATE_BY` varchar(100) DEFAULT NULL COMMENT 'Created date',
  `STAKE_HOLDER_UPDATE_DATE` datetime DEFAULT NULL COMMENT 'Updated by user',
  `STAKE_HOLDER_UPDATE_BY` varchar(100) DEFAULT NULL COMMENT 'Updated date',
  `STAKE_HOLDER_PERCENT_DISCOUNT` decimal(10,0) DEFAULT NULL COMMENT 'ส่วนลดที่ต้องการระบุ (%)',
  `STAKE_HOLDER_VAT` int(11) DEFAULT NULL COMMENT 'กำหนดภาษีมูลค่าเพิ่ม (%)',
  `STAKE_HOLDER_GROUP_ID` int(11) DEFAULT 0 COMMENT 'กลุ่ม / ประเภทลูกค้า',
  `STAKE_HOLDER_REF_SUPPLIER_ID` int(11) DEFAULT NULL COMMENT '-',
  `STAKE_HOLDER_STANDARD_RATE` decimal(10,0) DEFAULT NULL COMMENT 'กำหนดราคามาตรฐาน (บาท)',
  `STAKE_HOLDER_REMARK` mediumtext DEFAULT NULL COMMENT 'หมายเหตุ',
  `STAKE_HOLDER_WTH_TAX` int(11) DEFAULT NULL COMMENT 'กำหนดภาษีหัก ณ ที่จ่าย (%)',
  `STAKE_HOLDER_PROVINCE_ID` bigint(20) DEFAULT 0 COMMENT 'FK FROM tb_province',
  `stake_holder_type_of_wth_tax` varchar(255) DEFAULT NULL COMMENT '-',
  `customer_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_stake_holder_master',
  `account_department` varchar(100) DEFAULT NULL,
  `account_phone` varchar(50) DEFAULT NULL,
  `applicant` varchar(100) DEFAULT NULL,
  `referrer` varchar(100) DEFAULT NULL,
  `registered_capital` int(11) DEFAULT NULL,
  `credit_term_billing` int(11) DEFAULT NULL,
  `credit_limit_for_billing` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_sys_menu`
--

CREATE TABLE `tb_sys_menu` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_sys_permission`
--

CREATE TABLE `tb_sys_permission` (
  `id` bigint(20) NOT NULL,
  `role_mapping` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_tire_history`
--

CREATE TABLE `tb_tire_history` (
  `id` bigint(20) NOT NULL,
  `tire_id` bigint(20) NOT NULL COMMENT 'รหัสยางอ้างอิง (spare_parts_stock.id)',
  `change_type` varchar(50) NOT NULL COMMENT 'ประเภทการเปลี่ยนแปลง: TIRE_NAME_CHANGE, TIRE_BRAND_CHANGE',
  `old_value` varchar(500) DEFAULT NULL COMMENT 'ค่าเดิมก่อนการเปลี่ยนแปลง',
  `new_value` varchar(500) DEFAULT NULL COMMENT 'ค่าใหม่หลังการเปลี่ยนแปลง',
  `old_code` varchar(255) DEFAULT NULL COMMENT 'รหัสยางเดิม (สำหรับกรณีแก้ไขชื่อยาง)',
  `new_code` varchar(255) DEFAULT NULL COMMENT 'รหัสยางใหม่ (สำหรับกรณีแก้ไขชื่อยาง)',
  `old_parent_id` bigint(20) DEFAULT NULL COMMENT 'ID ของยี่ห้อยางเดิม (สำหรับกรณีแปลงยี่ห้อยาง)',
  `new_parent_id` bigint(20) DEFAULT NULL COMMENT 'ID ของยี่ห้อยางใหม่ (สำหรับกรณีแปลงยี่ห้อยาง)',
  `remark` text DEFAULT NULL COMMENT 'หมายเหตุเพิ่มเติม',
  `changed_by` varchar(100) NOT NULL COMMENT 'ผู้ทำการเปลี่ยนแปลง',
  `changed_date` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่และเวลาที่ทำการเปลี่ยนแปลง',
  `status` int(11) DEFAULT 1 COMMENT 'สถานะ (1=ใช้งาน, 0=ไม่ใช้งาน)',
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_tire_return_stock`
--

CREATE TABLE `tb_tire_return_stock` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `mileage` decimal(10,4) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `return_date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `tire_no` varchar(255) DEFAULT NULL,
  `maintenance_tire_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_truck`
--

CREATE TABLE `tb_truck` (
  `id` bigint(20) NOT NULL,
  `license_plate` varchar(255) DEFAULT NULL,
  `license_plate_type` varchar(255) DEFAULT NULL,
  `project` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_truck_cost_detail`
--

CREATE TABLE `tb_truck_cost_detail` (
  `id` bigint(20) NOT NULL,
  `truck_cost_master_id` bigint(20) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `status` int(10) DEFAULT 0,
  `status_petty_cash` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_truck_cost_master`
--

CREATE TABLE `tb_truck_cost_master` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_truck_profile`
--

CREATE TABLE `tb_truck_profile` (
  `Id` bigint(20) NOT NULL COMMENT 'PK',
  `TRUCK_NUMBER` mediumtext DEFAULT NULL COMMENT 'Truck number',
  `SUBSIDAIRY` varchar(60) DEFAULT NULL COMMENT 'Subsidiary',
  `PROVINCE` varchar(20) DEFAULT NULL COMMENT '-',
  `Yard_Id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_masteryard',
  `COMPANY` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_stake_holder_master',
  `PLATE_TYPE` varchar(50) DEFAULT NULL COMMENT 'Plate type',
  `TRUCK_TYPE` int(11) DEFAULT NULL COMMENT 'FK FROM tb_truck_type',
  `BRAND` varchar(20) DEFAULT NULL COMMENT 'Brand',
  `FUEL_TYPE` varchar(20) DEFAULT NULL COMMENT 'Types Of Fuels',
  `CONTAINER_BORDER_SIZE` varchar(120) DEFAULT NULL COMMENT '-',
  `CONTAINER_SIZE` varchar(120) DEFAULT NULL COMMENT '-',
  `AVAERAGE_FUEL` varchar(50) DEFAULT NULL COMMENT 'Specified rate',
  `PROJECT_ID` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_project',
  `LATEST_MILAGE` varchar(30) DEFAULT NULL COMMENT 'Latest on mileage',
  `FIRST_REGIST_DATE` varchar(20) DEFAULT NULL COMMENT 'Date of first registration',
  `TRUCK_AGE` decimal(10,6) DEFAULT NULL COMMENT '-',
  `EXPIRE_DATE` varchar(20) DEFAULT NULL COMMENT 'Date of expire',
  `MODEL` varchar(100) DEFAULT NULL COMMENT 'Model no',
  `TRUCK_STATUS` int(11) DEFAULT NULL COMMENT 'Status',
  `CHASSIS_NO` varchar(50) DEFAULT NULL COMMENT 'Chassis no',
  `ENGINE_NO` varchar(50) DEFAULT NULL COMMENT 'Engine no',
  `POSITION1` varchar(20) DEFAULT NULL COMMENT 'Position1',
  `POSITION2` varchar(20) DEFAULT NULL COMMENT 'Position2',
  `PUMP_NO` int(11) DEFAULT NULL COMMENT 'Pump no',
  `HPS` int(11) DEFAULT NULL COMMENT 'Horsepower',
  `WEIGHT` decimal(10,4) DEFAULT NULL COMMENT 'Weight',
  `WEIGHT_CARRY` decimal(10,4) DEFAULT NULL COMMENT 'Weight carry',
  `WEIGHT_TOTAL` decimal(10,4) DEFAULT NULL COMMENT 'Weight total',
  `ACT_ID` int(11) DEFAULT NULL COMMENT '-',
  `POLICY_ID` int(11) DEFAULT NULL COMMENT '-',
  `FLEETCARD_ID` int(11) DEFAULT NULL COMMENT '-',
  `GPS_TYPE_ID` int(11) DEFAULT NULL COMMENT 'FK FROM tb_gps_type',
  `SUPPLIER_SUM` int(11) DEFAULT NULL COMMENT '-',
  `TRUCK_AGE_YEAR` int(11) DEFAULT NULL COMMENT '-',
  `TRUCK_AGE_MONTH` int(11) DEFAULT NULL COMMENT '-',
  `INSTALLATION_DATE` varchar(20) DEFAULT NULL COMMENT '-',
  `ACT_CAR_NUM` varchar(150) DEFAULT NULL COMMENT '-',
  `ACT_CAR_EXPIRE` varchar(150) DEFAULT NULL COMMENT '-',
  `ACT_CAR_COMPANY` int(11) DEFAULT NULL COMMENT '-',
  `RENEW_DATE` varchar(20) DEFAULT NULL COMMENT '-',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT 'Created date',
  `CREATE_BY` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT 'Updated date',
  `UPDATE_BY` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `TRUCK_PROVINCE_ID` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_province',
  `TRUCK_DETAIL` varchar(255) DEFAULT NULL COMMENT 'Detail',
  `TRUCK_USAGE` varchar(255) DEFAULT NULL COMMENT '-',
  `COVER_BY` int(11) DEFAULT NULL COMMENT 'FK FROM tb_user',
  `REF_PERSON` int(11) DEFAULT NULL COMMENT 'Reference',
  `CONTAINER_BORDER_SIZE_W` decimal(10,2) DEFAULT NULL COMMENT 'Container border size W',
  `CONTAINER_BORDER_SIZE_L` decimal(10,2) DEFAULT NULL COMMENT 'Container border size L',
  `CONTAINER_BORDER_SIZE_H` decimal(10,2) DEFAULT NULL COMMENT 'Container border size H',
  `CONTAINER_SIZE_W` decimal(10,2) DEFAULT NULL COMMENT 'Container size W',
  `CONTAINER_SIZE_L` decimal(10,2) DEFAULT NULL COMMENT 'Container size L',
  `CONTAINER_SIZE_H` decimal(10,2) DEFAULT NULL COMMENT 'Container size H',
  `ACTIVE_DATE` datetime DEFAULT NULL COMMENT 'Active date',
  `PASSPORT_NO` varchar(50) DEFAULT NULL COMMENT 'Passport no',
  `truck_type_id` int(11) DEFAULT NULL COMMENT '-',
  `engine_brand` varchar(255) DEFAULT NULL COMMENT 'Engine brand',
  `enroll_description` varchar(255) DEFAULT NULL COMMENT 'Enroll description',
  `num_of_sit` int(11) NOT NULL COMMENT 'number of persons sit',
  `num_of_stand` int(11) NOT NULL COMMENT 'number of persons stand',
  `standard_feature` varchar(255) DEFAULT NULL COMMENT 'Standard feature',
  `color` varchar(255) DEFAULT NULL COMMENT 'Color'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_truck_profile_attachment`
--

CREATE TABLE `tb_truck_profile_attachment` (
  `attachment_no` varchar(30) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `attachment_name` varchar(255) DEFAULT NULL,
  `attachment_remark` text DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `thumbnail` text DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `truck_profile_id` bigint(20) NOT NULL,
  `truck_profile_attachment_type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_truck_profile_attachment_type`
--

CREATE TABLE `tb_truck_profile_attachment_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_truck_profile_image`
--

CREATE TABLE `tb_truck_profile_image` (
  `image_no` varchar(30) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `image_remark` text DEFAULT NULL,
  `thumbnail` text DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `truck_profile_id` bigint(20) NOT NULL,
  `truck_profile_image_type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_truck_profile_image_type`
--

CREATE TABLE `tb_truck_profile_image_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_truck_type`
--

CREATE TABLE `tb_truck_type` (
  `TYPE_ID` bigint(20) NOT NULL COMMENT 'PK',
  `TYPE_NAME` mediumtext DEFAULT NULL COMMENT 'ประเภทรถ',
  `TYPE_STATUS` tinyint(1) DEFAULT NULL COMMENT 'สถานะการใช้งาน',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT 'Created date',
  `CREATE_BY` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT 'Updated date',
  `UPDATE_BY` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `ref_sbg` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_truck_waiting_status`
--

CREATE TABLE `tb_truck_waiting_status` (
  `id` bigint(20) NOT NULL,
  `truck_profile_id` bigint(20) NOT NULL,
  `status_date` date NOT NULL,
  `waiting_status` varchar(50) NOT NULL,
  `remark` varchar(1000) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `Id` bigint(20) NOT NULL COMMENT 'PK',
  `username` varchar(20) NOT NULL COMMENT 'รหัสผู้ใช้',
  `password` varchar(50) DEFAULT '' COMMENT 'รหัสผ่าน',
  `role` int(11) DEFAULT NULL COMMENT 'สิทธิ์การใช้งาน',
  `name` varchar(70) DEFAULT NULL COMMENT 'ชื่อ',
  `lastname` varchar(70) DEFAULT NULL COMMENT 'นามสกุล',
  `department` int(11) DEFAULT NULL COMMENT '-',
  `email` varchar(80) DEFAULT NULL COMMENT '-',
  `contactnumber` varchar(11) DEFAULT NULL COMMENT '-',
  `status` tinyint(1) DEFAULT NULL COMMENT 'สถานะการใช้งาน',
  `joining_date` datetime DEFAULT NULL COMMENT '-',
  `last_login_date` datetime DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Created by user',
  `created_date` datetime DEFAULT NULL COMMENT 'Created date',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Updated by user',
  `updated_date` datetime DEFAULT NULL COMMENT 'Updated date',
  `title` varchar(255) DEFAULT NULL COMMENT '-',
  `employee_code` varchar(30) DEFAULT NULL COMMENT '-',
  `company_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user_company',
  `department_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user_department',
  `position_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user_position',
  `section_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user_section',
  `status_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user_status',
  `title_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user_title',
  `type_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user_type',
  `yard_id` bigint(20) DEFAULT NULL COMMENT 'FK FROM tb_user_yard',
  `emp_comp_id` bigint(20) DEFAULT NULL COMMENT '-',
  `emp_dpm_id` bigint(20) DEFAULT NULL COMMENT '-',
  `emp_position_id` bigint(20) DEFAULT NULL COMMENT '-',
  `emp_section_id` bigint(20) DEFAULT NULL COMMENT '-',
  `emp_type_id` bigint(20) DEFAULT NULL COMMENT '-',
  `age_month` int(11) DEFAULT NULL COMMENT 'อายุ(เดือน)',
  `age_year` int(11) DEFAULT NULL COMMENT 'อายุ(ปี)',
  `birth_date` datetime DEFAULT NULL COMMENT 'วันเดือนปีเกิด',
  `height` int(11) DEFAULT NULL COMMENT 'ส่วนสูง',
  `nickname` varchar(255) DEFAULT NULL COMMENT 'ชื่อเล่น',
  `weight` int(11) DEFAULT NULL COMMENT 'น้ำหนัก',
  `age_of_working_days_flag` char(1) DEFAULT NULL COMMENT '-',
  `allow_issue_worksheet_flag` char(1) DEFAULT NULL COMMENT '-',
  `allow_maintenance_system_flag` char(1) DEFAULT NULL COMMENT '-',
  `bank_account_no` varchar(50) DEFAULT NULL COMMENT 'เลขบัญชีธนาคาร',
  `bank_type` varchar(255) DEFAULT NULL COMMENT 'ประเภทบัญชีธนาคาร',
  `driving_license_expire_date` datetime DEFAULT NULL COMMENT 'วันหมดอายุ',
  `driving_license_no` varchar(20) DEFAULT NULL COMMENT 'เลขใบขับขี่',
  `education_description` mediumtext DEFAULT NULL COMMENT 'รายละเอียดเพิ่มเติมของการศึกษา',
  `education_skill` mediumtext DEFAULT NULL COMMENT 'ความสมารถพิเศษของการศึกษา',
  `end_date` datetime DEFAULT NULL COMMENT 'วันที่สิ้นสุดการใช้งาน',
  `id_card_address` mediumtext DEFAULT NULL COMMENT 'ที่อยู่ตามบัตรปชช',
  `id_card_address_postcode` varchar(20) DEFAULT NULL COMMENT 'รหัสไปรษณีย์ของบัตรปชช',
  `id_card_address_telephone` varchar(20) DEFAULT NULL COMMENT 'โทรศัพท์ของบัตรปชช',
  `id_card_expire_date` datetime DEFAULT NULL COMMENT 'วันที่หมดอายุของบัตรปชช',
  `id_card_issued_amphure` varchar(255) DEFAULT NULL COMMENT 'ออกให้ ณ อำเภอ',
  `id_card_no` varchar(13) DEFAULT NULL COMMENT 'หมายเลขบัตรประชาชน',
  `present_address` mediumtext DEFAULT NULL COMMENT 'ที่อยู่ปัจจุบัน',
  `present_address_email` varchar(255) DEFAULT NULL COMMENT 'อีเมล',
  `present_address_mobile` varchar(100) DEFAULT NULL COMMENT 'โทรศัพท์มือถือ',
  `present_address_passport` varchar(20) DEFAULT NULL COMMENT 'เลขพาสปอร์ต',
  `present_address_passport_expire_date` datetime DEFAULT NULL COMMENT 'วันที่หมดอายุของพาสปอร์ต',
  `present_address_postcode` varchar(20) DEFAULT NULL COMMENT 'รหัสไปรษณีย์',
  `present_address_tax_id` varchar(20) DEFAULT NULL COMMENT 'เลขประจำตัวผู้เสียภาษี',
  `present_address_telephone` varchar(100) DEFAULT NULL COMMENT 'โทรศัพท์',
  `reference_mobile` varchar(255) DEFAULT NULL COMMENT 'โทรศัพท์มือถือของบุคคลอ้างอิง',
  `reference_name` varchar(255) DEFAULT NULL COMMENT 'บุคคลอ้างอิง/ติดต่อได้',
  `reference_relationshipe` varchar(255) DEFAULT NULL COMMENT 'ความสัมพันธ์ที่เกี่ยวข้อง',
  `social_security_no` varchar(50) DEFAULT NULL COMMENT 'หมายเลขประกันสังคม',
  `start_date` datetime DEFAULT NULL COMMENT 'วันที่ใช้งาน',
  `starting_date` datetime DEFAULT NULL COMMENT 'วันที่เริ่มงาน',
  `wage_rate` decimal(19,2) DEFAULT NULL COMMENT 'อัตราค่าแรง',
  `working_days` int(11) DEFAULT NULL COMMENT 'จำนวนวันที่ทำงาน',
  `education_id` varchar(255) DEFAULT NULL COMMENT 'ระดับการศึกษา(FK FROM tb_education)',
  `idcard_addr_province_id` bigint(20) DEFAULT NULL COMMENT 'จังหวัดของบัตรปชช(FK FROM tb_province)',
  `idcard_issued_province_id` bigint(20) DEFAULT NULL COMMENT 'จังหวัดของที่ออกบัตรปชช(FK FROM tb_province)',
  `present_addr_bank_id` varchar(255) DEFAULT NULL COMMENT 'ธนาคาร(FK FROM tb_bank)',
  `present_addr_province_id` bigint(20) DEFAULT NULL COMMENT 'จังหวัดที่ติดต่อได้(FK FROM tb_province)',
  `gender_id` varchar(255) DEFAULT NULL COMMENT 'เพศ(FK FROM tb_user_gender)',
  `nationality_id` varchar(255) DEFAULT NULL COMMENT 'สัญชาติ(FK FROM tb_user_nationality)',
  `race_id` varchar(255) DEFAULT NULL COMMENT 'เชื้อชาติ(FK FROM tb_user_nationality)',
  `religion_id` varchar(255) DEFAULT NULL COMMENT 'ศาสนา(FK FROM tb_user_religion)',
  `cust_company_id` bigint(20) DEFAULT NULL,
  `type_info` varchar(20) DEFAULT NULL,
  `driving_license_type` int(20) DEFAULT NULL COMMENT '1=ท2,2=ท3,3=ท4,',
  `monthly_employee_flag` char(1) DEFAULT 'N' COMMENT 'เป็นพนักงานรายเดือน (Y=ใช่, N=ไม่ใช่)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_users_roles`
--

CREATE TABLE `tb_users_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_attachment`
--

CREATE TABLE `tb_user_attachment` (
  `attachment_no` varchar(30) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `attachment_name` varchar(255) DEFAULT NULL,
  `attachment_remark` text DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `thumbnail` text DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `user_attachment_type_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_company`
--

CREATE TABLE `tb_user_company` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_department`
--

CREATE TABLE `tb_user_department` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_gender`
--

CREATE TABLE `tb_user_gender` (
  `code` varchar(255) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_image`
--

CREATE TABLE `tb_user_image` (
  `image_no` varchar(30) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `image_remark` text DEFAULT NULL,
  `thumbnail` text DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `user_image_type_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_menu`
--

CREATE TABLE `tb_user_menu` (
  `code` varchar(255) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_nationality`
--

CREATE TABLE `tb_user_nationality` (
  `code` varchar(255) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_position`
--

CREATE TABLE `tb_user_position` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_religion`
--

CREATE TABLE `tb_user_religion` (
  `code` varchar(255) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_role`
--

CREATE TABLE `tb_user_role` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_role_menu`
--

CREATE TABLE `tb_user_role_menu` (
  `id` bigint(20) NOT NULL,
  `role_mapping` varchar(40) DEFAULT NULL,
  `menu_code` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_section`
--

CREATE TABLE `tb_user_section` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_status`
--

CREATE TABLE `tb_user_status` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_title`
--

CREATE TABLE `tb_user_title` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_type`
--

CREATE TABLE `tb_user_type` (
  `id` bigint(20) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_yard`
--

CREATE TABLE `tb_user_yard` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_goods_receipt_note`
-- (See below for the actual view)
--
CREATE TABLE `v_goods_receipt_note` (
`id` bigint(20)
,`grn_no` varchar(50)
,`grn_date` date
,`received_date` date
,`receiver_id` bigint(20)
,`receiver_name` varchar(100)
,`department` varchar(100)
,`vendor_id` bigint(20)
,`vendor_name` varchar(200)
,`vendor_address` text
,`vendor_phone` varchar(50)
,`vendor_email` varchar(100)
,`delivery_note_no` varchar(100)
,`invoice_no` varchar(100)
,`invoice_date` date
,`reference_no` varchar(100)
,`purchase_order_id` bigint(20)
,`purchase_order_ids` text
,`remarks` text
,`status` int(11)
,`sub_total` decimal(15,2)
,`withholding_tax_rate` decimal(5,2)
,`withholding_tax_amount` decimal(15,2)
,`net_total` decimal(15,2)
,`approved_by` bigint(20)
,`approved_date` datetime
,`rejected_by` bigint(20)
,`rejected_date` datetime
,`reject_reason` text
,`receiver_sign_date` datetime
,`approver_sign_date` datetime
,`created_by` varchar(50)
,`created_date` datetime
,`updated_by` varchar(50)
,`updated_date` datetime
,`status_name` varchar(9)
,`vendor_code` varchar(150)
,`vendor_tax_id` varchar(80)
,`vendor_bank_name` varchar(50)
,`vendor_bank_account` varchar(80)
,`vendor_bank_branch` varchar(50)
,`approved_by_name` varchar(141)
,`rejected_by_name` varchar(141)
,`created_by_name` varchar(141)
,`updated_by_name` varchar(141)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_goods_receipt_note_item`
-- (See below for the actual view)
--
CREATE TABLE `v_goods_receipt_note_item` (
`id` bigint(20)
,`goods_receipt_note_id` bigint(20)
,`line_no` int(11)
,`item_code` varchar(100)
,`item_description` text
,`ordered_quantity` decimal(15,4)
,`received_quantity` decimal(15,4)
,`unit` varchar(50)
,`unit_price` decimal(15,4)
,`total_amount` decimal(15,2)
,`purchase_order_id` bigint(20)
,`purchase_order_item_id` bigint(20)
,`po_no` varchar(50)
,`batch_no` varchar(100)
,`received_date` date
,`sps_id` bigint(20)
,`status` int(11)
,`remarks` text
,`created_by` varchar(50)
,`created_date` datetime
,`updated_by` varchar(50)
,`updated_date` datetime
,`grn_no` varchar(50)
,`grn_date` date
,`grn_received_date` date
,`grn_status` int(11)
,`original_po_no` varchar(50)
,`original_po_date` date
,`stock_code` varchar(255)
,`stock_name` varchar(255)
,`current_stock_qty` decimal(33,2)
,`status_name` varchar(9)
,`created_by_name` varchar(141)
,`updated_by_name` varchar(141)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_procurement_summary`
-- (See below for the actual view)
--
CREATE TABLE `v_procurement_summary` (
`department` varchar(100)
,`total_pr` bigint(21)
,`total_po` bigint(21)
,`total_grn` bigint(21)
,`pr_draft` decimal(22,0)
,`pr_submitted` decimal(22,0)
,`pr_approved` decimal(22,0)
,`pr_rejected` decimal(22,0)
,`po_draft` decimal(22,0)
,`po_submitted` decimal(22,0)
,`po_approved` decimal(22,0)
,`po_rejected` decimal(22,0)
,`grn_draft` decimal(22,0)
,`grn_submitted` decimal(22,0)
,`grn_approved` decimal(22,0)
,`grn_rejected` decimal(22,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_purchase_order`
-- (See below for the actual view)
--
CREATE TABLE `v_purchase_order` (
`id` bigint(20)
,`po_no` varchar(50)
,`po_date` date
,`requester_id` bigint(20)
,`requester_name` varchar(100)
,`department` varchar(100)
,`vendor_id` bigint(20)
,`vendor_name` varchar(200)
,`vendor_address` text
,`vendor_phone` varchar(50)
,`vendor_email` varchar(100)
,`delivery_date` date
,`payment_term` varchar(200)
,`remarks` text
,`status` int(11)
,`sub_total` decimal(15,2)
,`withholding_tax_rate` decimal(5,2)
,`withholding_tax_amount` decimal(15,2)
,`net_total` decimal(15,2)
,`approved_by` varchar(50)
,`approved_date` datetime
,`rejected_by` bigint(20)
,`rejected_date` datetime
,`reject_reason` text
,`pr_ids` text
,`created_by` varchar(50)
,`created_date` datetime
,`updated_by` varchar(50)
,`updated_date` datetime
,`status_name` varchar(11)
,`vendor_code` varchar(150)
,`vendor_tax_id` varchar(80)
,`vendor_bank_name` varchar(50)
,`vendor_bank_account` varchar(80)
,`vendor_bank_branch` varchar(50)
,`approved_by_name` varchar(141)
,`rejected_by_name` varchar(141)
,`created_by_name` varchar(141)
,`updated_by_name` varchar(141)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_purchase_order_item`
-- (See below for the actual view)
--
CREATE TABLE `v_purchase_order_item` (
`id` bigint(20)
,`po_id` bigint(20)
,`line_no` int(11)
,`item_code` varchar(100)
,`item_description` text
,`quantity` decimal(15,4)
,`received_quantity` decimal(15,4)
,`remaining_quantity` decimal(15,4)
,`unit` varchar(50)
,`unit_price` decimal(15,4)
,`total_amount` decimal(15,2)
,`pr_item_id` bigint(20)
,`pr_no` varchar(50)
,`item_status` int(11)
,`remarks` text
,`created_by` varchar(50)
,`created_date` datetime
,`updated_by` varchar(50)
,`updated_date` datetime
,`po_no` varchar(50)
,`po_date` date
,`po_status` int(11)
,`vendor_name` varchar(200)
,`original_pr_no` varchar(50)
,`original_pr_date` date
,`status_name` varchar(18)
,`created_by_name` varchar(141)
,`updated_by_name` varchar(141)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_purchase_requisition`
-- (See below for the actual view)
--
CREATE TABLE `v_purchase_requisition` (
`id` bigint(20)
,`pr_no` varchar(50)
,`pr_date` date
,`requester_id` bigint(20)
,`requester_name` varchar(100)
,`department` varchar(100)
,`expected_date` date
,`remarks` text
,`status` int(11)
,`sub_total` decimal(15,2)
,`withholding_tax_rate` decimal(5,2)
,`withholding_tax_amount` decimal(15,2)
,`net_total` decimal(15,2)
,`approved_by` varchar(50)
,`approved_date` datetime
,`rejected_by` bigint(20)
,`rejected_date` datetime
,`reject_reason` text
,`created_by` varchar(50)
,`created_date` datetime
,`updated_by` varchar(50)
,`updated_date` datetime
,`status_name` varchar(10)
,`approved_by_name` varchar(141)
,`rejected_by_name` varchar(141)
,`created_by_name` varchar(141)
,`updated_by_name` varchar(141)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_purchase_requisition_item`
-- (See below for the actual view)
--
CREATE TABLE `v_purchase_requisition_item` (
`id` bigint(20)
,`pr_id` bigint(20)
,`line_no` int(11)
,`item_code` varchar(100)
,`item_description` text
,`quantity` decimal(15,4)
,`unit` varchar(50)
,`unit_price` decimal(15,4)
,`total_amount` decimal(15,2)
,`status` int(11)
,`remarks` text
,`created_by` varchar(50)
,`created_date` datetime
,`updated_by` varchar(50)
,`updated_date` datetime
,`pr_no` varchar(50)
,`pr_date` date
,`pr_status` int(11)
,`status_name` varchar(9)
,`created_by_name` varchar(141)
,`updated_by_name` varchar(141)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_spare_parts_stock`
-- (See below for the actual view)
--
CREATE TABLE `v_spare_parts_stock` (
`id` bigint(20)
,`created_by` varchar(100)
,`created_date` datetime
,`updated_by` varchar(100)
,`updated_date` datetime
,`amount_unit` varchar(255)
,`code` varchar(255)
,`max_qty` double
,`min_qty` double
,`name` varchar(255)
,`price` double
,`qty` double
,`ref_doc_no` varchar(255)
,`stamp_date` datetime
,`status` int(11)
,`yard_id` bigint(20)
,`spare_parts_id` bigint(20)
,`spare_parts_type_id` bigint(20)
,`master_spare_part_unit_id` bigint(20)
,`current_qty` decimal(33,2)
,`status_name` varchar(8)
,`stock_status` varchar(13)
,`created_by_name` varchar(141)
,`updated_by_name` varchar(141)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_spare_parts_stock_detail`
-- (See below for the actual view)
--
CREATE TABLE `v_spare_parts_stock_detail` (
`id` bigint(20)
,`created_by` varchar(100)
,`created_date` datetime
,`updated_by` varchar(100)
,`updated_date` datetime
,`price` decimal(10,4)
,`qty` decimal(10,2)
,`remark` varchar(255)
,`stamp_date` datetime
,`status` int(11)
,`withdraw_qty` decimal(10,2)
,`spare_parts_stock_id` bigint(20)
,`flag` char(1)
,`move_stock_id` bigint(20)
,`po_no` varchar(255)
,`grn_id` bigint(20)
,`stock_code` varchar(255)
,`stock_name` varchar(255)
,`current_qty` decimal(33,2)
,`status_name` varchar(8)
,`flag_name` varchar(8)
,`created_by_name` varchar(141)
,`updated_by_name` varchar(141)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_stock_balance`
-- (See below for the actual view)
--
CREATE TABLE `v_stock_balance` (
`id` bigint(20)
,`code` varchar(255)
,`name` varchar(255)
,`unit` varchar(255)
,`current_balance` decimal(33,2)
,`min_qty` double
,`max_qty` double
,`stock_status` varchar(13)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_stock_detail`
-- (See below for the actual view)
--
CREATE TABLE `v_stock_detail` (
`id` bigint(20)
,`code` varchar(255)
,`name` varchar(255)
,`unit` varchar(255)
,`current_balance` decimal(33,2)
,`total_received` decimal(32,2)
,`total_withdrawn` decimal(32,2)
,`min_qty` double
,`max_qty` double
,`stock_status` varchar(13)
,`created_by_name` varchar(141)
,`updated_by_name` varchar(141)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_stock_movement`
-- (See below for the actual view)
--
CREATE TABLE `v_stock_movement` (
`movement_id` bigint(20)
,`stock_id` bigint(20)
,`code` varchar(255)
,`name` varchar(255)
,`unit` varchar(255)
,`movement_qty` decimal(10,2)
,`withdrawn_qty` decimal(10,2)
,`movement_type` char(1)
,`movement_date` datetime
,`current_balance` decimal(33,2)
,`min_qty` double
,`max_qty` double
,`stock_status` varchar(13)
,`created_by_name` varchar(141)
,`updated_by_name` varchar(141)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_stock_movement_summary`
-- (See below for the actual view)
--
CREATE TABLE `v_stock_movement_summary` (
`stock_id` bigint(20)
,`stock_code` varchar(255)
,`stock_name` varchar(255)
,`unit` varchar(255)
,`total_received` decimal(32,2)
,`total_withdrawn` decimal(32,2)
,`current_balance` decimal(33,2)
,`min_qty` double
,`max_qty` double
,`total_grn_receipts` bigint(21)
,`last_movement_date` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_stock_report`
-- (See below for the actual view)
--
CREATE TABLE `v_stock_report` (
`id` bigint(20)
,`code` varchar(255)
,`name` varchar(255)
,`unit` varchar(255)
,`current_balance` decimal(33,2)
,`total_received` decimal(32,2)
,`total_withdrawn` decimal(32,2)
,`min_qty` double
,`max_qty` double
,`stock_status` varchar(13)
,`created_by_name` varchar(141)
,`updated_by_name` varchar(141)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_stock_status`
-- (See below for the actual view)
--
CREATE TABLE `v_stock_status` (
`id` bigint(20)
,`code` varchar(255)
,`name` varchar(255)
,`unit` varchar(255)
,`current_balance` decimal(33,2)
,`min_qty` double
,`max_qty` double
,`stock_status` varchar(13)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_stock_summary`
-- (See below for the actual view)
--
CREATE TABLE `v_stock_summary` (
`id` bigint(20)
,`code` varchar(255)
,`name` varchar(255)
,`unit` varchar(255)
,`current_balance` decimal(33,2)
,`total_received` decimal(32,2)
,`total_withdrawn` decimal(32,2)
,`min_qty` double
,`max_qty` double
,`stock_status` varchar(13)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_stock_transaction`
-- (See below for the actual view)
--
CREATE TABLE `v_stock_transaction` (
`id` bigint(20)
,`code` varchar(255)
,`name` varchar(255)
,`unit` varchar(255)
,`current_balance` decimal(33,2)
,`total_received` decimal(32,2)
,`total_withdrawn` decimal(32,2)
,`min_qty` double
,`max_qty` double
,`stock_status` varchar(13)
);

-- --------------------------------------------------------

--
-- Structure for view `v_goods_receipt_note`
--
DROP TABLE IF EXISTS `v_goods_receipt_note`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_goods_receipt_note`  AS SELECT `grn`.`id` AS `id`, `grn`.`grn_no` AS `grn_no`, `grn`.`grn_date` AS `grn_date`, `grn`.`received_date` AS `received_date`, `grn`.`receiver_id` AS `receiver_id`, `grn`.`receiver_name` AS `receiver_name`, `grn`.`department` AS `department`, `grn`.`vendor_id` AS `vendor_id`, `grn`.`vendor_name` AS `vendor_name`, `grn`.`vendor_address` AS `vendor_address`, `grn`.`vendor_phone` AS `vendor_phone`, `grn`.`vendor_email` AS `vendor_email`, `grn`.`delivery_note_no` AS `delivery_note_no`, `grn`.`invoice_no` AS `invoice_no`, `grn`.`invoice_date` AS `invoice_date`, `grn`.`reference_no` AS `reference_no`, `grn`.`purchase_order_id` AS `purchase_order_id`, `grn`.`purchase_order_ids` AS `purchase_order_ids`, `grn`.`remarks` AS `remarks`, `grn`.`status` AS `status`, `grn`.`sub_total` AS `sub_total`, `grn`.`withholding_tax_rate` AS `withholding_tax_rate`, `grn`.`withholding_tax_amount` AS `withholding_tax_amount`, `grn`.`net_total` AS `net_total`, `grn`.`approved_by` AS `approved_by`, `grn`.`approved_date` AS `approved_date`, `grn`.`rejected_by` AS `rejected_by`, `grn`.`rejected_date` AS `rejected_date`, `grn`.`reject_reason` AS `reject_reason`, `grn`.`receiver_sign_date` AS `receiver_sign_date`, `grn`.`approver_sign_date` AS `approver_sign_date`, `grn`.`created_by` AS `created_by`, `grn`.`created_date` AS `created_date`, `grn`.`updated_by` AS `updated_by`, `grn`.`updated_date` AS `updated_date`, CASE WHEN `grn`.`status` = 1 THEN 'Draft' WHEN `grn`.`status` = 2 THEN 'Submitted' WHEN `grn`.`status` = 3 THEN 'Approved' WHEN `grn`.`status` = 4 THEN 'Rejected' ELSE 'Unknown' END AS `status_name`, `v`.`STAKE_HOLDER_ID` AS `vendor_code`, `v`.`STAKE_HOLDER_TAX_NO` AS `vendor_tax_id`, `v`.`STAKE_HOLDER_REF_BANK` AS `vendor_bank_name`, `v`.`STAKE_HOLDER_REF_ACCOUNT_NO` AS `vendor_bank_account`, `v`.`STAKE_HOLDER_REF_BANK_BRANCH` AS `vendor_bank_branch`, concat(`approver`.`name`,' ',`approver`.`lastname`) AS `approved_by_name`, concat(`rejecter`.`name`,' ',`rejecter`.`lastname`) AS `rejected_by_name`, concat(`creator`.`name`,' ',`creator`.`lastname`) AS `created_by_name`, concat(`updater`.`name`,' ',`updater`.`lastname`) AS `updated_by_name` FROM (((((`tb_goods_receipt_note` `grn` left join `tb_stake_holder_master` `v` on(`grn`.`vendor_id` = `v`.`STAKE_HOLDER_UN_ID`)) left join `tb_user` `approver` on(`grn`.`approved_by` = `approver`.`Id`)) left join `tb_user` `rejecter` on(`grn`.`rejected_by` = `rejecter`.`Id`)) left join `tb_user` `creator` on(`grn`.`created_by` = `creator`.`Id`)) left join `tb_user` `updater` on(`grn`.`updated_by` = `updater`.`Id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_goods_receipt_note_item`
--
DROP TABLE IF EXISTS `v_goods_receipt_note_item`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_goods_receipt_note_item`  AS SELECT `grni`.`id` AS `id`, `grni`.`goods_receipt_note_id` AS `goods_receipt_note_id`, `grni`.`line_no` AS `line_no`, `grni`.`item_code` AS `item_code`, `grni`.`item_description` AS `item_description`, `grni`.`ordered_quantity` AS `ordered_quantity`, `grni`.`received_quantity` AS `received_quantity`, `grni`.`unit` AS `unit`, `grni`.`unit_price` AS `unit_price`, `grni`.`total_amount` AS `total_amount`, `grni`.`purchase_order_id` AS `purchase_order_id`, `grni`.`purchase_order_item_id` AS `purchase_order_item_id`, `grni`.`po_no` AS `po_no`, `grni`.`batch_no` AS `batch_no`, `grni`.`received_date` AS `received_date`, `grni`.`sps_id` AS `sps_id`, `grni`.`status` AS `status`, `grni`.`remarks` AS `remarks`, `grni`.`created_by` AS `created_by`, `grni`.`created_date` AS `created_date`, `grni`.`updated_by` AS `updated_by`, `grni`.`updated_date` AS `updated_date`, `grn`.`grn_no` AS `grn_no`, `grn`.`grn_date` AS `grn_date`, `grn`.`received_date` AS `grn_received_date`, `grn`.`status` AS `grn_status`, `po`.`po_no` AS `original_po_no`, `po`.`po_date` AS `original_po_date`, `sps`.`code` AS `stock_code`, `sps`.`name` AS `stock_name`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_stock_qty`, CASE WHEN `grni`.`status` = 1 THEN 'Draft' WHEN `grni`.`status` = 2 THEN 'Submitted' WHEN `grni`.`status` = 3 THEN 'Approved' WHEN `grni`.`status` = 4 THEN 'Rejected' ELSE 'Unknown' END AS `status_name`, concat(`creator`.`name`,' ',`creator`.`lastname`) AS `created_by_name`, concat(`updater`.`name`,' ',`updater`.`lastname`) AS `updated_by_name` FROM ((((((`tb_goods_receipt_note_item` `grni` left join `tb_goods_receipt_note` `grn` on(`grni`.`goods_receipt_note_id` = `grn`.`id`)) left join `tb_purchase_order` `po` on(`grn`.`purchase_order_id` = `po`.`id`)) left join `tb_spare_parts_stock` `sps` on(`grni`.`sps_id` = `sps`.`id`)) left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) left join `tb_user` `creator` on(`grni`.`created_by` = `creator`.`Id`)) left join `tb_user` `updater` on(`grni`.`updated_by` = `updater`.`Id`)) GROUP BY `grni`.`id` ;

-- --------------------------------------------------------

--
-- Structure for view `v_procurement_summary`
--
DROP TABLE IF EXISTS `v_procurement_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_procurement_summary`  AS WITH stock_qty AS (SELECT `sps`.`id` AS `id`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_qty` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`)  SELECT `pr`.`department` AS `department`, count(distinct `pr`.`id`) AS `total_pr`, count(distinct `po`.`id`) AS `total_po`, count(distinct `grn`.`id`) AS `total_grn`, sum(case when `pr`.`status` = 1 then 1 else 0 end) AS `pr_draft`, sum(case when `pr`.`status` = 2 then 1 else 0 end) AS `pr_submitted`, sum(case when `pr`.`status` = 3 then 1 else 0 end) AS `pr_approved`, sum(case when `pr`.`status` = 4 then 1 else 0 end) AS `pr_rejected`, sum(case when `po`.`status` = 1 then 1 else 0 end) AS `po_draft`, sum(case when `po`.`status` = 2 then 1 else 0 end) AS `po_submitted`, sum(case when `po`.`status` = 3 then 1 else 0 end) AS `po_approved`, sum(case when `po`.`status` = 4 then 1 else 0 end) AS `po_rejected`, sum(case when `grn`.`status` = 1 then 1 else 0 end) AS `grn_draft`, sum(case when `grn`.`status` = 2 then 1 else 0 end) AS `grn_submitted`, sum(case when `grn`.`status` = 3 then 1 else 0 end) AS `grn_approved`, sum(case when `grn`.`status` = 4 then 1 else 0 end) AS `grn_rejected` FROM ((`tb_purchase_requisition` `pr` left join `tb_purchase_order` `po` on(`po`.`department` = `pr`.`department`)) left join `tb_goods_receipt_note` `grn` on(`grn`.`department` = `pr`.`department`)) GROUP BY coalesce(`pr`.`department`,`po`.`department`,`grn`.`department`))  ;

-- --------------------------------------------------------

--
-- Structure for view `v_purchase_order`
--
DROP TABLE IF EXISTS `v_purchase_order`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_purchase_order`  AS SELECT `po`.`id` AS `id`, `po`.`po_no` AS `po_no`, `po`.`po_date` AS `po_date`, `po`.`requester_id` AS `requester_id`, `po`.`requester_name` AS `requester_name`, `po`.`department` AS `department`, `po`.`vendor_id` AS `vendor_id`, `po`.`vendor_name` AS `vendor_name`, `po`.`vendor_address` AS `vendor_address`, `po`.`vendor_phone` AS `vendor_phone`, `po`.`vendor_email` AS `vendor_email`, `po`.`delivery_date` AS `delivery_date`, `po`.`payment_term` AS `payment_term`, `po`.`remarks` AS `remarks`, `po`.`status` AS `status`, `po`.`sub_total` AS `sub_total`, `po`.`withholding_tax_rate` AS `withholding_tax_rate`, `po`.`withholding_tax_amount` AS `withholding_tax_amount`, `po`.`net_total` AS `net_total`, `po`.`approved_by` AS `approved_by`, `po`.`approved_date` AS `approved_date`, `po`.`rejected_by` AS `rejected_by`, `po`.`rejected_date` AS `rejected_date`, `po`.`reject_reason` AS `reject_reason`, `po`.`pr_ids` AS `pr_ids`, `po`.`created_by` AS `created_by`, `po`.`created_date` AS `created_date`, `po`.`updated_by` AS `updated_by`, `po`.`updated_date` AS `updated_date`, CASE WHEN `po`.`status` = 1 THEN 'Draft' WHEN `po`.`status` = 2 THEN 'Submitted' WHEN `po`.`status` = 3 THEN 'Approved' WHEN `po`.`status` = 4 THEN 'Rejected' WHEN `po`.`status` = 5 THEN 'GRN Created' ELSE 'Unknown' END AS `status_name`, `v`.`STAKE_HOLDER_ID` AS `vendor_code`, `v`.`STAKE_HOLDER_TAX_NO` AS `vendor_tax_id`, `v`.`STAKE_HOLDER_REF_BANK` AS `vendor_bank_name`, `v`.`STAKE_HOLDER_REF_ACCOUNT_NO` AS `vendor_bank_account`, `v`.`STAKE_HOLDER_REF_BANK_BRANCH` AS `vendor_bank_branch`, concat(`approver`.`name`,' ',`approver`.`lastname`) AS `approved_by_name`, concat(`rejecter`.`name`,' ',`rejecter`.`lastname`) AS `rejected_by_name`, concat(`creator`.`name`,' ',`creator`.`lastname`) AS `created_by_name`, concat(`updater`.`name`,' ',`updater`.`lastname`) AS `updated_by_name` FROM (((((`tb_purchase_order` `po` left join `tb_stake_holder_master` `v` on(`po`.`vendor_id` = `v`.`STAKE_HOLDER_UN_ID`)) left join `tb_user` `approver` on(`po`.`approved_by` = `approver`.`Id`)) left join `tb_user` `rejecter` on(`po`.`rejected_by` = `rejecter`.`Id`)) left join `tb_user` `creator` on(`po`.`created_by` = `creator`.`Id`)) left join `tb_user` `updater` on(`po`.`updated_by` = `updater`.`Id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_purchase_order_item`
--
DROP TABLE IF EXISTS `v_purchase_order_item`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_purchase_order_item`  AS SELECT `poi`.`id` AS `id`, `poi`.`po_id` AS `po_id`, `poi`.`line_no` AS `line_no`, `poi`.`item_code` AS `item_code`, `poi`.`item_description` AS `item_description`, `poi`.`quantity` AS `quantity`, `poi`.`received_quantity` AS `received_quantity`, `poi`.`remaining_quantity` AS `remaining_quantity`, `poi`.`unit` AS `unit`, `poi`.`unit_price` AS `unit_price`, `poi`.`total_amount` AS `total_amount`, `poi`.`pr_item_id` AS `pr_item_id`, `poi`.`pr_no` AS `pr_no`, `poi`.`item_status` AS `item_status`, `poi`.`remarks` AS `remarks`, `poi`.`created_by` AS `created_by`, `poi`.`created_date` AS `created_date`, `poi`.`updated_by` AS `updated_by`, `poi`.`updated_date` AS `updated_date`, `po`.`po_no` AS `po_no`, `po`.`po_date` AS `po_date`, `po`.`status` AS `po_status`, `po`.`vendor_name` AS `vendor_name`, `pr`.`pr_no` AS `original_pr_no`, `pr`.`pr_date` AS `original_pr_date`, CASE WHEN `poi`.`item_status` = 1 THEN 'Pending' WHEN `poi`.`item_status` = 2 THEN 'Fully Received' WHEN `poi`.`item_status` = 3 THEN 'Partially Received' WHEN `poi`.`item_status` = 4 THEN 'Cancelled' ELSE 'Unknown' END AS `status_name`, concat(`creator`.`name`,' ',`creator`.`lastname`) AS `created_by_name`, concat(`updater`.`name`,' ',`updater`.`lastname`) AS `updated_by_name` FROM (((((`tb_purchase_order_item` `poi` join `tb_purchase_order` `po` on(`poi`.`po_id` = `po`.`id`)) left join `tb_purchase_requisition_item` `pri` on(`poi`.`pr_item_id` = `pri`.`id`)) left join `tb_purchase_requisition` `pr` on(`pri`.`pr_id` = `pr`.`id`)) left join `tb_user` `creator` on(`poi`.`created_by` = `creator`.`Id`)) left join `tb_user` `updater` on(`poi`.`updated_by` = `updater`.`Id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_purchase_requisition`
--
DROP TABLE IF EXISTS `v_purchase_requisition`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_purchase_requisition`  AS SELECT `pr`.`id` AS `id`, `pr`.`pr_no` AS `pr_no`, `pr`.`pr_date` AS `pr_date`, `pr`.`requester_id` AS `requester_id`, `pr`.`requester_name` AS `requester_name`, `pr`.`department` AS `department`, `pr`.`expected_date` AS `expected_date`, `pr`.`remarks` AS `remarks`, `pr`.`status` AS `status`, `pr`.`sub_total` AS `sub_total`, `pr`.`withholding_tax_rate` AS `withholding_tax_rate`, `pr`.`withholding_tax_amount` AS `withholding_tax_amount`, `pr`.`net_total` AS `net_total`, `pr`.`approved_by` AS `approved_by`, `pr`.`approved_date` AS `approved_date`, `pr`.`rejected_by` AS `rejected_by`, `pr`.`rejected_date` AS `rejected_date`, `pr`.`reject_reason` AS `reject_reason`, `pr`.`created_by` AS `created_by`, `pr`.`created_date` AS `created_date`, `pr`.`updated_by` AS `updated_by`, `pr`.`updated_date` AS `updated_date`, CASE WHEN `pr`.`status` = 1 THEN 'Draft' WHEN `pr`.`status` = 2 THEN 'Submitted' WHEN `pr`.`status` = 3 THEN 'Approved' WHEN `pr`.`status` = 4 THEN 'Rejected' WHEN `pr`.`status` = 5 THEN 'PO Created' ELSE 'Unknown' END AS `status_name`, concat(`approver`.`name`,' ',`approver`.`lastname`) AS `approved_by_name`, concat(`rejecter`.`name`,' ',`rejecter`.`lastname`) AS `rejected_by_name`, concat(`creator`.`name`,' ',`creator`.`lastname`) AS `created_by_name`, concat(`updater`.`name`,' ',`updater`.`lastname`) AS `updated_by_name` FROM ((((`tb_purchase_requisition` `pr` left join `tb_user` `approver` on(`pr`.`approved_by` = `approver`.`Id`)) left join `tb_user` `rejecter` on(`pr`.`rejected_by` = `rejecter`.`Id`)) left join `tb_user` `creator` on(`pr`.`created_by` = `creator`.`Id`)) left join `tb_user` `updater` on(`pr`.`updated_by` = `updater`.`Id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_purchase_requisition_item`
--
DROP TABLE IF EXISTS `v_purchase_requisition_item`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_purchase_requisition_item`  AS SELECT `pri`.`id` AS `id`, `pri`.`pr_id` AS `pr_id`, `pri`.`line_no` AS `line_no`, `pri`.`item_code` AS `item_code`, `pri`.`item_description` AS `item_description`, `pri`.`quantity` AS `quantity`, `pri`.`unit` AS `unit`, `pri`.`unit_price` AS `unit_price`, `pri`.`total_amount` AS `total_amount`, `pri`.`status` AS `status`, `pri`.`remarks` AS `remarks`, `pri`.`created_by` AS `created_by`, `pri`.`created_date` AS `created_date`, `pri`.`updated_by` AS `updated_by`, `pri`.`updated_date` AS `updated_date`, `pr`.`pr_no` AS `pr_no`, `pr`.`pr_date` AS `pr_date`, `pr`.`status` AS `pr_status`, CASE WHEN `pri`.`status` = 1 THEN 'Pending' WHEN `pri`.`status` = 2 THEN 'Ordered' WHEN `pri`.`status` = 3 THEN 'Cancelled' ELSE 'Unknown' END AS `status_name`, concat(`creator`.`name`,' ',`creator`.`lastname`) AS `created_by_name`, concat(`updater`.`name`,' ',`updater`.`lastname`) AS `updated_by_name` FROM (((`tb_purchase_requisition_item` `pri` join `tb_purchase_requisition` `pr` on(`pri`.`pr_id` = `pr`.`id`)) left join `tb_user` `creator` on(`pri`.`created_by` = `creator`.`Id`)) left join `tb_user` `updater` on(`pri`.`updated_by` = `updater`.`Id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_spare_parts_stock`
--
DROP TABLE IF EXISTS `v_spare_parts_stock`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_spare_parts_stock`  AS WITH stock_qty AS (SELECT `sps`.`id` AS `id`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_qty` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`)  SELECT `sps`.`id` AS `id`, `sps`.`created_by` AS `created_by`, `sps`.`created_date` AS `created_date`, `sps`.`updated_by` AS `updated_by`, `sps`.`updated_date` AS `updated_date`, `sps`.`amount_unit` AS `amount_unit`, `sps`.`code` AS `code`, `sps`.`max_qty` AS `max_qty`, `sps`.`min_qty` AS `min_qty`, `sps`.`name` AS `name`, `sps`.`price` AS `price`, `sps`.`qty` AS `qty`, `sps`.`ref_doc_no` AS `ref_doc_no`, `sps`.`stamp_date` AS `stamp_date`, `sps`.`status` AS `status`, `sps`.`yard_id` AS `yard_id`, `sps`.`spare_parts_id` AS `spare_parts_id`, `sps`.`spare_parts_type_id` AS `spare_parts_type_id`, `sps`.`master_spare_part_unit_id` AS `master_spare_part_unit_id`, `sq`.`current_qty` AS `current_qty`, CASE WHEN `sps`.`status` = 1 THEN 'Active' WHEN `sps`.`status` = 0 THEN 'Inactive' ELSE 'Unknown' END AS `status_name`, CASE WHEN `sq`.`current_qty` <= `sps`.`min_qty` THEN 'Below Minimum' WHEN `sq`.`current_qty` >= `sps`.`max_qty` THEN 'Above Maximum' ELSE 'Normal' END AS `stock_status`, concat(`creator`.`name`,' ',`creator`.`lastname`) AS `created_by_name`, concat(`updater`.`name`,' ',`updater`.`lastname`) AS `updated_by_name` FROM (((`tb_spare_parts_stock` `sps` join `stock_qty` `sq` on(`sps`.`id` = `sq`.`id`)) left join `tb_user` `creator` on(`sps`.`created_by` = `creator`.`Id`)) left join `tb_user` `updater` on(`sps`.`updated_by` = `updater`.`Id`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `v_spare_parts_stock_detail`
--
DROP TABLE IF EXISTS `v_spare_parts_stock_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_spare_parts_stock_detail`  AS WITH stock_qty AS (SELECT `sps`.`id` AS `id`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_qty` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`)  SELECT `spsd`.`id` AS `id`, `spsd`.`created_by` AS `created_by`, `spsd`.`created_date` AS `created_date`, `spsd`.`updated_by` AS `updated_by`, `spsd`.`updated_date` AS `updated_date`, `spsd`.`price` AS `price`, `spsd`.`qty` AS `qty`, `spsd`.`remark` AS `remark`, `spsd`.`stamp_date` AS `stamp_date`, `spsd`.`status` AS `status`, `spsd`.`withdraw_qty` AS `withdraw_qty`, `spsd`.`spare_parts_stock_id` AS `spare_parts_stock_id`, `spsd`.`flag` AS `flag`, `spsd`.`move_stock_id` AS `move_stock_id`, `spsd`.`po_no` AS `po_no`, `spsd`.`grn_id` AS `grn_id`, `sps`.`code` AS `stock_code`, `sps`.`name` AS `stock_name`, `sq`.`current_qty` AS `current_qty`, CASE WHEN `spsd`.`status` = 1 THEN 'Active' WHEN `spsd`.`status` = 0 THEN 'Inactive' ELSE 'Unknown' END AS `status_name`, CASE WHEN `spsd`.`flag` = 'G' THEN 'General' WHEN `spsd`.`flag` = 'W' THEN 'Withdraw' ELSE 'Unknown' END AS `flag_name`, concat(`creator`.`name`,' ',`creator`.`lastname`) AS `created_by_name`, concat(`updater`.`name`,' ',`updater`.`lastname`) AS `updated_by_name` FROM ((((`tb_spare_parts_stock_detail` `spsd` left join `tb_spare_parts_stock` `sps` on(`spsd`.`spare_parts_stock_id` = `sps`.`id`)) join `stock_qty` `sq` on(`sps`.`id` = `sq`.`id`)) left join `tb_user` `creator` on(`spsd`.`created_by` = `creator`.`Id`)) left join `tb_user` `updater` on(`spsd`.`updated_by` = `updater`.`Id`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `v_stock_balance`
--
DROP TABLE IF EXISTS `v_stock_balance`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_stock_balance`  AS WITH stock_qty AS (SELECT `sps`.`id` AS `id`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_qty` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`) SELECT `sps`.`id` AS `id`, `sps`.`code` AS `code`, `sps`.`name` AS `name`, `sps`.`amount_unit` AS `unit`, `sq`.`current_qty` AS `current_balance`, `sps`.`min_qty` AS `min_qty`, `sps`.`max_qty` AS `max_qty`, CASE WHEN `sq`.`current_qty` <= `sps`.`min_qty` THEN 'Below Minimum' WHEN `sq`.`current_qty` >= `sps`.`max_qty` THEN 'Above Maximum' ELSE 'Normal' END AS `stock_status` FROM (`tb_spare_parts_stock` `sps` join `stock_qty` `sq` on(`sps`.`id` = `sq`.`id`)) GROUP BY `sps`.`id`, `sps`.`code`, `sps`.`name`, `sps`.`amount_unit`, `sps`.`min_qty`, `sps`.`max_qty`, `sq`.`current_qty``current_qty`  ;

-- --------------------------------------------------------

--
-- Structure for view `v_stock_detail`
--
DROP TABLE IF EXISTS `v_stock_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_stock_detail`  AS WITH stock_qty AS (SELECT `sps`.`id` AS `id`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_qty` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`), movement_totals AS (SELECT `sps`.`id` AS `id`, sum(case when `spsd`.`flag` = 'G' then `spsd`.`qty` else 0 end) AS `total_received`, sum(case when `spsd`.`flag` = 'W' then `spsd`.`withdraw_qty` else 0 end) AS `total_withdrawn` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`) SELECT `sps`.`id` AS `id`, `sps`.`code` AS `code`, `sps`.`name` AS `name`, `sps`.`amount_unit` AS `unit`, `sq`.`current_qty` AS `current_balance`, `mt`.`total_received` AS `total_received`, `mt`.`total_withdrawn` AS `total_withdrawn`, `sps`.`min_qty` AS `min_qty`, `sps`.`max_qty` AS `max_qty`, CASE WHEN `sq`.`current_qty` <= `sps`.`min_qty` THEN 'Below Minimum' WHEN `sq`.`current_qty` >= `sps`.`max_qty` THEN 'Above Maximum' ELSE 'Normal' END AS `stock_status`, concat(`creator`.`name`,' ',`creator`.`lastname`) AS `created_by_name`, concat(`updater`.`name`,' ',`updater`.`lastname`) AS `updated_by_name` FROM ((((`tb_spare_parts_stock` `sps` join `stock_qty` `sq` on(`sps`.`id` = `sq`.`id`)) left join `movement_totals` `mt` on(`sps`.`id` = `mt`.`id`)) left join `tb_user` `creator` on(`sps`.`created_by` = `creator`.`Id`)) left join `tb_user` `updater` on(`sps`.`updated_by` = `updater`.`Id`)) WHERE `sps`.`status` = 11  ;

-- --------------------------------------------------------

--
-- Structure for view `v_stock_movement`
--
DROP TABLE IF EXISTS `v_stock_movement`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_stock_movement`  AS WITH stock_qty AS (SELECT `sps`.`id` AS `id`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_qty` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`) SELECT `spsd`.`id` AS `movement_id`, `sps`.`id` AS `stock_id`, `sps`.`code` AS `code`, `sps`.`name` AS `name`, `sps`.`amount_unit` AS `unit`, `spsd`.`qty` AS `movement_qty`, `spsd`.`withdraw_qty` AS `withdrawn_qty`, `spsd`.`flag` AS `movement_type`, `spsd`.`stamp_date` AS `movement_date`, `sq`.`current_qty` AS `current_balance`, `sps`.`min_qty` AS `min_qty`, `sps`.`max_qty` AS `max_qty`, CASE WHEN `sq`.`current_qty` <= `sps`.`min_qty` THEN 'Below Minimum' WHEN `sq`.`current_qty` >= `sps`.`max_qty` THEN 'Above Maximum' ELSE 'Normal' END AS `stock_status`, concat(`creator`.`name`,' ',`creator`.`lastname`) AS `created_by_name`, concat(`updater`.`name`,' ',`updater`.`lastname`) AS `updated_by_name` FROM ((((`tb_spare_parts_stock` `sps` join `stock_qty` `sq` on(`sps`.`id` = `sq`.`id`)) left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) left join `tb_user` `creator` on(`spsd`.`created_by` = `creator`.`Id`)) left join `tb_user` `updater` on(`spsd`.`updated_by` = `updater`.`Id`)) WHERE `sps`.`status` = 11  ;

-- --------------------------------------------------------

--
-- Structure for view `v_stock_movement_summary`
--
DROP TABLE IF EXISTS `v_stock_movement_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_stock_movement_summary`  AS WITH stock_qty AS (SELECT `sps`.`id` AS `id`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_qty` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`) SELECT `sps`.`id` AS `stock_id`, `sps`.`code` AS `stock_code`, `sps`.`name` AS `stock_name`, `sps`.`amount_unit` AS `unit`, sum(case when `spsd`.`flag` = 'G' then `spsd`.`qty` else 0 end) AS `total_received`, sum(case when `spsd`.`flag` = 'W' then `spsd`.`withdraw_qty` else 0 end) AS `total_withdrawn`, `sq`.`current_qty` AS `current_balance`, `sps`.`min_qty` AS `min_qty`, `sps`.`max_qty` AS `max_qty`, count(distinct `spsd`.`grn_id`) AS `total_grn_receipts`, max(`spsd`.`created_date`) AS `last_movement_date` FROM ((`tb_spare_parts_stock` `sps` join `stock_qty` `sq` on(`sps`.`id` = `sq`.`id`)) left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) WHERE `sps`.`status` = 1 GROUP BY `sps`.`id`, `sps`.`code`, `sps`.`name`, `sps`.`amount_unit`, `sq`.`current_qty`, `sps`.`min_qty`, `sps`.`max_qty``max_qty`  ;

-- --------------------------------------------------------

--
-- Structure for view `v_stock_report`
--
DROP TABLE IF EXISTS `v_stock_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_stock_report`  AS WITH stock_qty AS (SELECT `sps`.`id` AS `id`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_qty` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`), movement_totals AS (SELECT `sps`.`id` AS `id`, sum(case when `spsd`.`flag` = 'G' then `spsd`.`qty` else 0 end) AS `total_received`, sum(case when `spsd`.`flag` = 'W' then `spsd`.`withdraw_qty` else 0 end) AS `total_withdrawn` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`) SELECT `sps`.`id` AS `id`, `sps`.`code` AS `code`, `sps`.`name` AS `name`, `sps`.`amount_unit` AS `unit`, `sq`.`current_qty` AS `current_balance`, `mt`.`total_received` AS `total_received`, `mt`.`total_withdrawn` AS `total_withdrawn`, `sps`.`min_qty` AS `min_qty`, `sps`.`max_qty` AS `max_qty`, CASE WHEN `sq`.`current_qty` <= `sps`.`min_qty` THEN 'Below Minimum' WHEN `sq`.`current_qty` >= `sps`.`max_qty` THEN 'Above Maximum' ELSE 'Normal' END AS `stock_status`, concat(`creator`.`name`,' ',`creator`.`lastname`) AS `created_by_name`, concat(`updater`.`name`,' ',`updater`.`lastname`) AS `updated_by_name` FROM ((((`tb_spare_parts_stock` `sps` join `stock_qty` `sq` on(`sps`.`id` = `sq`.`id`)) left join `movement_totals` `mt` on(`sps`.`id` = `mt`.`id`)) left join `tb_user` `creator` on(`sps`.`created_by` = `creator`.`Id`)) left join `tb_user` `updater` on(`sps`.`updated_by` = `updater`.`Id`)) WHERE `sps`.`status` = 11  ;

-- --------------------------------------------------------

--
-- Structure for view `v_stock_status`
--
DROP TABLE IF EXISTS `v_stock_status`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_stock_status`  AS WITH stock_qty AS (SELECT `sps`.`id` AS `id`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_qty` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`) SELECT `sps`.`id` AS `id`, `sps`.`code` AS `code`, `sps`.`name` AS `name`, `sps`.`amount_unit` AS `unit`, `sq`.`current_qty` AS `current_balance`, `sps`.`min_qty` AS `min_qty`, `sps`.`max_qty` AS `max_qty`, CASE WHEN `sq`.`current_qty` <= `sps`.`min_qty` THEN 'Below Minimum' WHEN `sq`.`current_qty` >= `sps`.`max_qty` THEN 'Above Maximum' ELSE 'Normal' END AS `stock_status` FROM (`tb_spare_parts_stock` `sps` join `stock_qty` `sq` on(`sps`.`id` = `sq`.`id`)) WHERE `sps`.`status` = 11  ;

-- --------------------------------------------------------

--
-- Structure for view `v_stock_summary`
--
DROP TABLE IF EXISTS `v_stock_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_stock_summary`  AS WITH stock_qty AS (SELECT `sps`.`id` AS `id`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_qty` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`), movement_totals AS (SELECT `sps`.`id` AS `id`, sum(case when `spsd`.`flag` = 'G' then `spsd`.`qty` else 0 end) AS `total_received`, sum(case when `spsd`.`flag` = 'W' then `spsd`.`withdraw_qty` else 0 end) AS `total_withdrawn` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`) SELECT `sps`.`id` AS `id`, `sps`.`code` AS `code`, `sps`.`name` AS `name`, `sps`.`amount_unit` AS `unit`, `sq`.`current_qty` AS `current_balance`, `mt`.`total_received` AS `total_received`, `mt`.`total_withdrawn` AS `total_withdrawn`, `sps`.`min_qty` AS `min_qty`, `sps`.`max_qty` AS `max_qty`, CASE WHEN `sq`.`current_qty` <= `sps`.`min_qty` THEN 'Below Minimum' WHEN `sq`.`current_qty` >= `sps`.`max_qty` THEN 'Above Maximum' ELSE 'Normal' END AS `stock_status` FROM ((`tb_spare_parts_stock` `sps` join `stock_qty` `sq` on(`sps`.`id` = `sq`.`id`)) left join `movement_totals` `mt` on(`sps`.`id` = `mt`.`id`)) WHERE `sps`.`status` = 11  ;

-- --------------------------------------------------------

--
-- Structure for view `v_stock_transaction`
--
DROP TABLE IF EXISTS `v_stock_transaction`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_stock_transaction`  AS WITH stock_qty AS (SELECT `sps`.`id` AS `id`, coalesce(sum(`spsd`.`qty` - `spsd`.`withdraw_qty`),0) AS `current_qty` FROM (`tb_spare_parts_stock` `sps` left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) GROUP BY `sps`.`id`) SELECT `sps`.`id` AS `id`, `sps`.`code` AS `code`, `sps`.`name` AS `name`, `sps`.`amount_unit` AS `unit`, `sq`.`current_qty` AS `current_balance`, sum(case when `spsd`.`flag` = 'G' then `spsd`.`qty` else 0 end) AS `total_received`, sum(case when `spsd`.`flag` = 'W' then `spsd`.`withdraw_qty` else 0 end) AS `total_withdrawn`, `sps`.`min_qty` AS `min_qty`, `sps`.`max_qty` AS `max_qty`, CASE WHEN `sq`.`current_qty` <= `sps`.`min_qty` THEN 'Below Minimum' WHEN `sq`.`current_qty` >= `sps`.`max_qty` THEN 'Above Maximum' ELSE 'Normal' END AS `stock_status` FROM ((`tb_spare_parts_stock` `sps` join `stock_qty` `sq` on(`sps`.`id` = `sq`.`id`)) left join `tb_spare_parts_stock_detail` `spsd` on(`sps`.`id` = `spsd`.`spare_parts_stock_id`)) WHERE `sps`.`status` = 1 GROUP BY `sps`.`id`, `sps`.`code`, `sps`.`name`, `sps`.`amount_unit`, `sps`.`min_qty`, `sps`.`max_qty`, `sq`.`current_qty``current_qty`  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qrtz_blob_triggers`
--
ALTER TABLE `qrtz_blob_triggers`
  ADD PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`);

--
-- Indexes for table `qrtz_calendars`
--
ALTER TABLE `qrtz_calendars`
  ADD PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`);

--
-- Indexes for table `qrtz_cron_triggers`
--
ALTER TABLE `qrtz_cron_triggers`
  ADD PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`);

--
-- Indexes for table `qrtz_fired_triggers`
--
ALTER TABLE `qrtz_fired_triggers`
  ADD PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`);

--
-- Indexes for table `qrtz_job_details`
--
ALTER TABLE `qrtz_job_details`
  ADD PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`);

--
-- Indexes for table `qrtz_locks`
--
ALTER TABLE `qrtz_locks`
  ADD PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`);

--
-- Indexes for table `qrtz_paused_trigger_grps`
--
ALTER TABLE `qrtz_paused_trigger_grps`
  ADD PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`);

--
-- Indexes for table `qrtz_scheduler_state`
--
ALTER TABLE `qrtz_scheduler_state`
  ADD PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`);

--
-- Indexes for table `qrtz_simple_triggers`
--
ALTER TABLE `qrtz_simple_triggers`
  ADD PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`);

--
-- Indexes for table `qrtz_simprop_triggers`
--
ALTER TABLE `qrtz_simprop_triggers`
  ADD PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`);

--
-- Indexes for table `qrtz_triggers`
--
ALTER TABLE `qrtz_triggers`
  ADD PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  ADD KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`);

--
-- Indexes for table `tb_accident_area_type`
--
ALTER TABLE `tb_accident_area_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_accident_type`
--
ALTER TABLE `tb_accident_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_advance_payment_master`
--
ALTER TABLE `tb_advance_payment_master`
  ADD PRIMARY KEY (`advance_payment_id`),
  ADD KEY `FK1309fbmjhepc5bdf8e2kyv5wd` (`project_id`),
  ADD KEY `FKi8l86tr6dig0ergx19qxbmgfc` (`received_by_id`);

--
-- Indexes for table `tb_allowance_master`
--
ALTER TABLE `tb_allowance_master`
  ADD PRIMARY KEY (`allowance_no`),
  ADD KEY `FK9oer8p1yeggwdvstk4fadxki1` (`driver_id`),
  ADD KEY `FKqka81brntuydun7utffn3s8hi` (`job_type_id`),
  ADD KEY `FK4xi8398e0vjycls7vk4putkub` (`project_id`),
  ADD KEY `FKb8r3fxt4g5pdmn7ftow8isesn` (`truck_tractor_id`);

--
-- Indexes for table `tb_allowance_sub_master`
--
ALTER TABLE `tb_allowance_sub_master`
  ADD PRIMARY KEY (`allowance_sub_no`),
  ADD KEY `FK6930ur8u2w2xtuqj9xip427a3` (`job_type_id`),
  ADD KEY `FK6g4jhod8vhm45ehdpojjtpx0r` (`project_id`),
  ADD KEY `FKqpkxjdvyd60dcefyesn35o6wx` (`supplier_id`);

--
-- Indexes for table `tb_bank`
--
ALTER TABLE `tb_bank`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `tb_carrier`
--
ALTER TABLE `tb_carrier`
  ADD PRIMARY KEY (`carrierID`);

--
-- Indexes for table `tb_city`
--
ALTER TABLE `tb_city`
  ADD PRIMARY KEY (`cityID`);

--
-- Indexes for table `tb_container_size`
--
ALTER TABLE `tb_container_size`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_credit_term`
--
ALTER TABLE `tb_credit_term`
  ADD PRIMARY KEY (`CREDIT_TERM_ID`);

--
-- Indexes for table `tb_customer`
--
ALTER TABLE `tb_customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_customer_attachment`
--
ALTER TABLE `tb_customer_attachment`
  ADD PRIMARY KEY (`attachment_no`),
  ADD KEY `FK7iscci07slgshi9p9tctce4ed` (`user_id`);

--
-- Indexes for table `tb_customer_group`
--
ALTER TABLE `tb_customer_group`
  ADD PRIMARY KEY (`customer_group_id`);

--
-- Indexes for table `tb_cust_job_type`
--
ALTER TABLE `tb_cust_job_type`
  ADD KEY `FKrvslda4b4qqlgiypnsiwkfhw7` (`job_type_id`),
  ADD KEY `FKawm0a19iakc4rhqfei3qo7f15` (`cust_user_id`);

--
-- Indexes for table `tb_cust_project`
--
ALTER TABLE `tb_cust_project`
  ADD KEY `FK6l6399uq9ujdrvll1i6k4kxxo` (`project_id`),
  ADD KEY `FK7jqcyr2jj38eb9ovvf7xktwel` (`cust_user_id`);

--
-- Indexes for table `tb_department`
--
ALTER TABLE `tb_department`
  ADD PRIMARY KEY (`departmentId`);

--
-- Indexes for table `tb_driver_leave`
--
ALTER TABLE `tb_driver_leave`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_driver_leave_date` (`driver_id`,`leave_date`);

--
-- Indexes for table `tb_education`
--
ALTER TABLE `tb_education`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `tb_emp_company`
--
ALTER TABLE `tb_emp_company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_emp_department`
--
ALTER TABLE `tb_emp_department`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_emp_position`
--
ALTER TABLE `tb_emp_position`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_emp_section`
--
ALTER TABLE `tb_emp_section`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_emp_type`
--
ALTER TABLE `tb_emp_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_expense_detail`
--
ALTER TABLE `tb_expense_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK6omniivl5m7yf73inkh1k3jbm` (`expense_id`);

--
-- Indexes for table `tb_expense_master`
--
ALTER TABLE `tb_expense_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_fault_accident_type`
--
ALTER TABLE `tb_fault_accident_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_fleet_card`
--
ALTER TABLE `tb_fleet_card`
  ADD PRIMARY KEY (`FLEETCARD_ID`);

--
-- Indexes for table `tb_fuel_input`
--
ALTER TABLE `tb_fuel_input`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKmgsxc937mn62n3gouxi7gqthp` (`driver_id`),
  ADD KEY `FKno6k203ndejoojg1a2mgki5r0` (`gas_station_id`),
  ADD KEY `ix_fuel_input` (`truck_tractor_id`,`gas_station_id`,`driver_id`);

--
-- Indexes for table `tb_gas_station`
--
ALTER TABLE `tb_gas_station`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_goods_receipt_note`
--
ALTER TABLE `tb_goods_receipt_note`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_grn_no` (`grn_no`),
  ADD KEY `idx_grn_status` (`status`),
  ADD KEY `idx_grn_date` (`grn_date`),
  ADD KEY `idx_grn_po` (`purchase_order_id`),
  ADD KEY `idx_grn_vendor` (`vendor_id`),
  ADD KEY `idx_grn_receiver` (`receiver_id`),
  ADD KEY `FKcc7ervys41ggtt7ypqqwnqvjv` (`approved_by`),
  ADD KEY `FK4qaamc5flih00oee5xf54dtjo` (`rejected_by`);

--
-- Indexes for table `tb_goods_receipt_note_item`
--
ALTER TABLE `tb_goods_receipt_note_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_grn_item_grn_id` (`goods_receipt_note_id`),
  ADD KEY `idx_grn_item_code` (`item_code`),
  ADD KEY `idx_grn_item_po_item` (`purchase_order_item_id`),
  ADD KEY `idx_grn_item_sps` (`sps_id`),
  ADD KEY `FK53oo7693gacnpjvo4lve16iur` (`po_item_id`);

--
-- Indexes for table `tb_goods_receipt_note_sub_item`
--
ALTER TABLE `tb_goods_receipt_note_sub_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_grn_sub_item_main_item` (`goods_receipt_note_item_id`),
  ADD KEY `idx_grn_sub_item_code` (`sub_item_code`),
  ADD KEY `idx_grn_sub_item_serial` (`sub_item_serial_no`),
  ADD KEY `idx_grn_sub_item_status` (`status`);

--
-- Indexes for table `tb_gps_type`
--
ALTER TABLE `tb_gps_type`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tb_gsdb_code`
--
ALTER TABLE `tb_gsdb_code`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `FK3huq2bjfaey4392d7e3vhm3w7` (`GSDB_PROVINCE_ID`);

--
-- Indexes for table `tb_gsdb_delivery_type`
--
ALTER TABLE `tb_gsdb_delivery_type`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tb_history_tire`
--
ALTER TABLE `tb_history_tire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK6jwwffr8mo4596qw2wv81l4el` (`maintenance_tire_id`),
  ADD KEY `FK3sxf6qkyve7qttojy5ca767yv` (`truck_profile_id`);

--
-- Indexes for table `tb_income_type`
--
ALTER TABLE `tb_income_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_insurance_act`
--
ALTER TABLE `tb_insurance_act`
  ADD PRIMARY KEY (`ACT_ID`),
  ADD KEY `ACT_RESPONSE_BY` (`ACT_RESPONSE_BY`),
  ADD KEY `FKtrp6nx5n8myl04mgqy4y3i13k` (`truck_id`),
  ADD KEY `FK8afashd8j8rx82l3jrkx6cft8` (`act_insurance_company`);

--
-- Indexes for table `tb_insurance_company`
--
ALTER TABLE `tb_insurance_company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_insurance_cover_product`
--
ALTER TABLE `tb_insurance_cover_product`
  ADD PRIMARY KEY (`POLICY_ID`),
  ADD KEY `INSURANCE_RESPONSE_BY` (`INSURANCE_RESPONSE_BY`),
  ADD KEY `FKrv73scf9r9rh4yh1xgvbl3ag9` (`truck_id`),
  ADD KEY `FKgyoi4qafd7h0ap4onobelgn4c` (`insurance_company`);

--
-- Indexes for table `tb_invoice_cover_master`
--
ALTER TABLE `tb_invoice_cover_master`
  ADD PRIMARY KEY (`invoice_cover_no`),
  ADD KEY `FKc3x9l10lswg06m7c58tff4rwv` (`customer_id`),
  ADD KEY `FKgl6w4j3p1baepx88bpd9i75ao` (`project_id`);

--
-- Indexes for table `tb_invoice_excel_group`
--
ALTER TABLE `tb_invoice_excel_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_invoice_excel_mapping`
--
ALTER TABLE `tb_invoice_excel_mapping`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKpruq7wan08kib2vruhrn8y1ti` (`job_type_id`),
  ADD KEY `FKlfjw3skxjtbh2axiew1qw4wjs` (`project_id`),
  ADD KEY `FK9ff74ym1yqj49vtmi75cdb5cm` (`invoice_excel_group_id`);

--
-- Indexes for table `tb_invoice_item`
--
ALTER TABLE `tb_invoice_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKoppj1caxn11093tw1rd6s1ju9` (`invoice_id`);

--
-- Indexes for table `tb_invoice_master`
--
ALTER TABLE `tb_invoice_master`
  ADD PRIMARY KEY (`invoice_no`),
  ADD KEY `FK88fgi16hfj4jtkopd7udhahlr` (`job_type_id`),
  ADD KEY `FKkjoo8g6tgstmf3h80nr2g5daq` (`project_id`),
  ADD KEY `FK8toldt0w77x6s115gglth2mdu` (`customer_id`);

--
-- Indexes for table `tb_job_cost`
--
ALTER TABLE `tb_job_cost`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK60nnnur1upiwacl6y5y54v12s` (`job_id`),
  ADD KEY `FKel2yjlbcosstxtwpewrjbl8jw` (`truck_cost_detail_id`),
  ADD KEY `FKem06mkdochqj86y2dubterspa` (`truck_cost_id`),
  ADD KEY `FKqprnoypxjnajc8oqmftketeoi` (`supplier_id`),
  ADD KEY `FKjy3bsrlv3uacysxvagnah58o` (`driver_id`),
  ADD KEY `FKqpi7o6e45ol68lkkco8yu1itr` (`user_id`),
  ADD KEY `idx_job_cost` (`job_id`,`truck_cost_id`,`truck_cost_detail_id`,`driver_id`,`supplier_id`,`petty_cash_no`),
  ADD KEY `FKcw1q1oo2arc9moof3nw6097cd` (`truck_tractor_id`),
  ADD KEY `idx_job_cost_job_id_status` (`job_id`,`status`,`with_draw`);

--
-- Indexes for table `tb_job_cost2021_2023`
--
ALTER TABLE `tb_job_cost2021_2023`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK60nnnur1upiwacl6y5y54v12s` (`job_id`),
  ADD KEY `FKel2yjlbcosstxtwpewrjbl8jw` (`truck_cost_detail_id`),
  ADD KEY `FKem06mkdochqj86y2dubterspa` (`truck_cost_id`),
  ADD KEY `FKqprnoypxjnajc8oqmftketeoi` (`supplier_id`),
  ADD KEY `FKjy3bsrlv3uacysxvagnah58o` (`driver_id`),
  ADD KEY `FKqpi7o6e45ol68lkkco8yu1itr` (`user_id`),
  ADD KEY `idx_job_cost` (`job_id`,`truck_cost_id`,`truck_cost_detail_id`,`driver_id`,`supplier_id`,`petty_cash_no`),
  ADD KEY `FKcw1q1oo2arc9moof3nw6097cd` (`truck_tractor_id`);

--
-- Indexes for table `tb_job_fuel`
--
ALTER TABLE `tb_job_fuel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKgie95vhrt6w1v94rt21595pkk` (`job_id`),
  ADD KEY `FK4f7mmto3ce1brpu5ttqwu96r6` (`job_route_id`),
  ADD KEY `FK2visn36qbjp7ixkv388cb50fb` (`gas_station_id`),
  ADD KEY `ix_job_fuel` (`job_id`,`job_route_id`,`gas_station_id`,`mileage`,`type`),
  ADD KEY `FKm6o3yli3v3i2maeormpf0sm7p` (`gsdb_id`),
  ADD KEY `FK6tn4dimd3xj14wft25ilho6pw` (`truck_tractor_id`);

--
-- Indexes for table `tb_job_fuel2021_2023`
--
ALTER TABLE `tb_job_fuel2021_2023`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKgie95vhrt6w1v94rt21595pkk` (`job_id`),
  ADD KEY `FK4f7mmto3ce1brpu5ttqwu96r6` (`job_route_id`),
  ADD KEY `FK2visn36qbjp7ixkv388cb50fb` (`gas_station_id`),
  ADD KEY `ix_job_fuel` (`job_id`,`job_route_id`,`gas_station_id`,`mileage`,`type`),
  ADD KEY `FKm6o3yli3v3i2maeormpf0sm7p` (`gsdb_id`),
  ADD KEY `FK6tn4dimd3xj14wft25ilho6pw` (`truck_tractor_id`);

--
-- Indexes for table `tb_job_income`
--
ALTER TABLE `tb_job_income`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK5ab1wbjqvlttlhut5y28fw5sj` (`income_type_id`),
  ADD KEY `FKe3ksq99efgpe8aaxf3tl15nbs` (`job_id`),
  ADD KEY `ix_job_inc` (`job_id`);

--
-- Indexes for table `tb_job_income2021_2023`
--
ALTER TABLE `tb_job_income2021_2023`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK5ab1wbjqvlttlhut5y28fw5sj` (`income_type_id`),
  ADD KEY `FKe3ksq99efgpe8aaxf3tl15nbs` (`job_id`),
  ADD KEY `ix_job_inc` (`job_id`);

--
-- Indexes for table `tb_job_master`
--
ALTER TABLE `tb_job_master`
  ADD PRIMARY KEY (`job_id`),
  ADD KEY `FKm4l41taxhry4qbovvqibxek49` (`quotation_item_id`),
  ADD KEY `FK4u3wyadx9p07a5g7o7oei5qq5` (`route_id`),
  ADD KEY `FK1q3gwty994egyx3yk4ln0svar` (`customer_id`),
  ADD KEY `FKbl5rvdkkpbkt0f40kyy6k6ggl` (`truck_type_id`),
  ADD KEY `FK2golmycpq4pgh6m6eede6j8do` (`driver_id`),
  ADD KEY `FKt6p8wiggu43yj8x2cp1ah52o5` (`route_truck_type_id`),
  ADD KEY `FKkcyinxpkqrwhx6bn0b80lk0r3` (`quotation_id`),
  ADD KEY `FK1p1maj0i4spcpmv37dirf0eo2` (`driver_id_2`),
  ADD KEY `FKs145sqgutvaxgrmwd9h987sqd` (`truck_tractor_id`),
  ADD KEY `FKa55cdxf7yp5s150vu1i1me5oi` (`truck_trailer_id`),
  ADD KEY `FKchyd9lhm34vog9k8jq5o7wngq` (`container_size_id`),
  ADD KEY `ix_job_master` (`truck_tractor_id`),
  ADD KEY `FKop4a4lkw2apspkpugtnrtxty1` (`cost_truck_type_id`),
  ADD KEY `FKrn498vfw0qos98m7o6vrla769` (`driver_id_3`),
  ADD KEY `FK3p9wg1m46hlfil5g1xaubyoja` (`driver_id_4`),
  ADD KEY `idx_job_master_stamp_date_status` (`stamp_date`,`status`),
  ADD KEY `idx_job_master_truck_status` (`truck_tractor_id`,`status`),
  ADD KEY `idx_job_master_stakeholder` (`customer_id`,`status`);

--
-- Indexes for table `tb_job_master2021_2023`
--
ALTER TABLE `tb_job_master2021_2023`
  ADD PRIMARY KEY (`job_id`),
  ADD KEY `FKm4l41taxhry4qbovvqibxek49` (`quotation_item_id`),
  ADD KEY `FK4u3wyadx9p07a5g7o7oei5qq5` (`route_id`),
  ADD KEY `FK1q3gwty994egyx3yk4ln0svar` (`customer_id`),
  ADD KEY `FKbl5rvdkkpbkt0f40kyy6k6ggl` (`truck_type_id`),
  ADD KEY `FK2golmycpq4pgh6m6eede6j8do` (`driver_id`),
  ADD KEY `FKt6p8wiggu43yj8x2cp1ah52o5` (`route_truck_type_id`),
  ADD KEY `FKkcyinxpkqrwhx6bn0b80lk0r3` (`quotation_id`),
  ADD KEY `FK1p1maj0i4spcpmv37dirf0eo2` (`driver_id_2`),
  ADD KEY `FKs145sqgutvaxgrmwd9h987sqd` (`truck_tractor_id`),
  ADD KEY `FKa55cdxf7yp5s150vu1i1me5oi` (`truck_trailer_id`),
  ADD KEY `FKchyd9lhm34vog9k8jq5o7wngq` (`container_size_id`),
  ADD KEY `ix_job_master` (`truck_tractor_id`),
  ADD KEY `FKop4a4lkw2apspkpugtnrtxty1` (`cost_truck_type_id`),
  ADD KEY `FKrn498vfw0qos98m7o6vrla769` (`driver_id_3`),
  ADD KEY `FK3p9wg1m46hlfil5g1xaubyoja` (`driver_id_4`);

--
-- Indexes for table `tb_job_notification`
--
ALTER TABLE `tb_job_notification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_job_order_template_download`
--
ALTER TABLE `tb_job_order_template_download`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `idx_token` (`token`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_created_date` (`created_date`),
  ADD KEY `idx_used` (`used`);

--
-- Indexes for table `tb_job_reserve_payment`
--
ALTER TABLE `tb_job_reserve_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKeb3ltraetbcnypssy8g6fy765` (`job_id`),
  ADD KEY `FKsti9wnq3gp3823016rpla302r` (`advance_payment_id`),
  ADD KEY `FK1ep6xxqi0a65eik0c295oo71` (`truck_cost_detail_id`);

--
-- Indexes for table `tb_job_reserve_payment2021_2023`
--
ALTER TABLE `tb_job_reserve_payment2021_2023`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKeb3ltraetbcnypssy8g6fy765` (`job_id`),
  ADD KEY `FKsti9wnq3gp3823016rpla302r` (`advance_payment_id`),
  ADD KEY `FK1ep6xxqi0a65eik0c295oo71` (`truck_cost_detail_id`);

--
-- Indexes for table `tb_job_route`
--
ALTER TABLE `tb_job_route`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK45xiwy80fo6cddbbe0wo8u84i` (`route_detail_id`),
  ADD KEY `FK6ppy8fb74b5cqye3fq9w123yu` (`job_id`),
  ADD KEY `FKs8qmtpkhn3nojnl4wcltoxh6i` (`gsdb_id`),
  ADD KEY `ix_plan_in_out` (`id`,`job_id`,`status`),
  ADD KEY `FKd4u453jxe08j75nl291ln098a` (`driver_id`),
  ADD KEY `FKlanipl2vrqe0toly2t0a8m560` (`gsdb_id2`),
  ADD KEY `FKc8aaub4s4ryhy5ddgq6ljro1x` (`truck_tractor_id`),
  ADD KEY `FKf2euicqgjpsnvyic683ye2jde` (`truck_trailer_id`);

--
-- Indexes for table `tb_job_route2021_2023`
--
ALTER TABLE `tb_job_route2021_2023`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK45xiwy80fo6cddbbe0wo8u84i` (`route_detail_id`),
  ADD KEY `FK6ppy8fb74b5cqye3fq9w123yu` (`job_id`),
  ADD KEY `FKs8qmtpkhn3nojnl4wcltoxh6i` (`gsdb_id`),
  ADD KEY `ix_plan_in_out` (`id`,`job_id`,`status`),
  ADD KEY `FKd4u453jxe08j75nl291ln098a` (`driver_id`),
  ADD KEY `FKlanipl2vrqe0toly2t0a8m560` (`gsdb_id2`),
  ADD KEY `FKc8aaub4s4ryhy5ddgq6ljro1x` (`truck_tractor_id`),
  ADD KEY `FKf2euicqgjpsnvyic683ye2jde` (`truck_trailer_id`);

--
-- Indexes for table `tb_job_type`
--
ALTER TABLE `tb_job_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_load`
--
ALTER TABLE `tb_load`
  ADD PRIMARY KEY (`loadID`);

--
-- Indexes for table `tb_loadstop`
--
ALTER TABLE `tb_loadstop`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_lock_report_ctrl`
--
ALTER TABLE `tb_lock_report_ctrl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_log_advance_payment_master`
--
ALTER TABLE `tb_log_advance_payment_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_log_allowance_master`
--
ALTER TABLE `tb_log_allowance_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_log_invoice_master`
--
ALTER TABLE `tb_log_invoice_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_log_job_cost`
--
ALTER TABLE `tb_log_job_cost`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_job_cost_id` (`job_cost_id`),
  ADD KEY `idx_action_type` (`action_type`),
  ADD KEY `idx_log_timestamp` (`log_timestamp`),
  ADD KEY `idx_job_id` (`job_id`),
  ADD KEY `idx_log_user` (`log_user`);

--
-- Indexes for table `tb_log_job_master`
--
ALTER TABLE `tb_log_job_master`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_app_log_job_master` (`job_no`,`activity`);

--
-- Indexes for table `tb_log_job_route`
--
ALTER TABLE `tb_log_job_route`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_job_route_id` (`job_route_id`),
  ADD KEY `idx_action_type` (`action_type`),
  ADD KEY `idx_log_timestamp` (`log_timestamp`),
  ADD KEY `idx_job_id` (`job_id`),
  ADD KEY `idx_log_user` (`log_user`);

--
-- Indexes for table `tb_log_receipt_master`
--
ALTER TABLE `tb_log_receipt_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_log_receipt_ra_master`
--
ALTER TABLE `tb_log_receipt_ra_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_log_sr_master`
--
ALTER TABLE `tb_log_sr_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_maintenance`
--
ALTER TABLE `tb_maintenance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKkviuw2g7dl1556dte8bvmhu3d` (`driver_id`),
  ADD KEY `FKlow86buba282debnyl79ihdwl` (`repairman_id`),
  ADD KEY `FK6rda4oy87pqwyhx4x3j0i3ofx` (`repairman_id_2`),
  ADD KEY `FKmbfrbjvpip6jqov459873ipwh` (`driver_id_2`),
  ADD KEY `FK6wycx2mbko8l7thif2cvjbbhk` (`project_id`),
  ADD KEY `FKqmohqw5800ybyp1t1r3ku0vey` (`yard_id`),
  ADD KEY `FK7j1mjubdxsbp76l8pskuj0rap` (`master_preventive_setup_item_id`),
  ADD KEY `FKm289gn9p7okjfl578ktnrtoq5` (`stake_holder_id`),
  ADD KEY `ix_maintenance` (`truck_profile_id`,`master_preventive_setup_item_id`);

--
-- Indexes for table `tb_maintenance_invoice`
--
ALTER TABLE `tb_maintenance_invoice`
  ADD PRIMARY KEY (`ma_invoice_no`),
  ADD KEY `FKgdmnqxx4d2e1vpqinylp7yg3b` (`maintenance_id`),
  ADD KEY `FKpygh0bjeug9se3866fvsmj1qj` (`supplier_id`);

--
-- Indexes for table `tb_maintenance_preventive`
--
ALTER TABLE `tb_maintenance_preventive`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKffcg12haql97eeegtw4mxjgmv` (`ma_id`),
  ADD KEY `FKcs2y5vgp6vtc94ledrf1xl4nm` (`preventive_checklist_id`),
  ADD KEY `FK5s2yjdaobp2v82gnincxqxjk8` (`preventive_setup_detail_id`);

--
-- Indexes for table `tb_maintenance_service_cost`
--
ALTER TABLE `tb_maintenance_service_cost`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKb9tjnbv03chilqm5j5rux9y69` (`ma_id`),
  ADD KEY `FKrryxx2tmr0cg9r3ggh7otbhvk` (`ma_spare_part_id`),
  ADD KEY `FK1dfcql7y3cskcp3j1nfig83iy` (`ma_service_type_id`);

--
-- Indexes for table `tb_maintenance_spare_part`
--
ALTER TABLE `tb_maintenance_spare_part`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKb4aq8fi195see85ew1tacp5gt` (`maintenance_id`),
  ADD KEY `FK9g5kcdj720sddlsd2rw16dhn1` (`spare_parts_stock_id`);

--
-- Indexes for table `tb_maintenance_tire`
--
ALTER TABLE `tb_maintenance_tire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKnwi844o7dewafo6ci6fhxkoyy` (`maintenance_id`),
  ADD KEY `FKnykui33wy3m9h7exxwdxn3edy` (`spare_parts_stock_id`),
  ADD KEY `FKgsgwuww6639546t8vg7dj14wk` (`pre_history_tire_id`);

--
-- Indexes for table `tb_masteryard`
--
ALTER TABLE `tb_masteryard`
  ADD PRIMARY KEY (`Yard_Id`);

--
-- Indexes for table `tb_master_maintenance_service_cost_type`
--
ALTER TABLE `tb_master_maintenance_service_cost_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_master_preventive_checklist`
--
ALTER TABLE `tb_master_preventive_checklist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK39xjqymumyb3yck0av4160uww` (`preventive_mainsystem_id`);

--
-- Indexes for table `tb_master_preventive_mainsystem`
--
ALTER TABLE `tb_master_preventive_mainsystem`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_master_preventive_setup`
--
ALTER TABLE `tb_master_preventive_setup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_master_preventive_setup` (`brand`,`fuel_type`);

--
-- Indexes for table `tb_master_preventive_setup_detail`
--
ALTER TABLE `tb_master_preventive_setup_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKmmu95gdy36x2n455o9169rbbo` (`preventive_checklist_id`),
  ADD KEY `FKonhu58ac4pwwfehngto85mrm5` (`preventive_setup_item_id`);

--
-- Indexes for table `tb_master_preventive_setup_item`
--
ALTER TABLE `tb_master_preventive_setup_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_master_preventive_setup_item` (`preventive_setup_id`,`mileage`);

--
-- Indexes for table `tb_master_spare_part_unit`
--
ALTER TABLE `tb_master_spare_part_unit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_menu`
--
ALTER TABLE `tb_menu`
  ADD PRIMARY KEY (`menu_id`);

--
-- Indexes for table `tb_move_stock`
--
ALTER TABLE `tb_move_stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKrd68wr1dmpe6wagnkqipccb7q` (`dep_sps_id`),
  ADD KEY `FK1w90fy9ywno4rnipq3jmuity5` (`des_sps_id`);

--
-- Indexes for table `tb_move_stock_pdf`
--
ALTER TABLE `tb_move_stock_pdf`
  ADD PRIMARY KEY (`move_stock_pdf_no`),
  ADD KEY `FK8oj981nlnsop66gnxvlrw8xht` (`yard_dtn_id`),
  ADD KEY `FK8474luc7yobd41qcoquel73q0` (`yard_org_id`);

--
-- Indexes for table `tb_payment_method`
--
ALTER TABLE `tb_payment_method`
  ADD PRIMARY KEY (`PAYMENT_METHOD_ID`);

--
-- Indexes for table `tb_permission`
--
ALTER TABLE `tb_permission`
  ADD PRIMARY KEY (`permission_id`),
  ADD KEY `Menu` (`id_menu`),
  ADD KEY `tb_permission_ibfk_1` (`id_roles`);

--
-- Indexes for table `tb_petty_cash_cost`
--
ALTER TABLE `tb_petty_cash_cost`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK47i6cdr5x7fqjomau6iuerxrd` (`accounting_id`),
  ADD KEY `FK87m454a0t39mvg53pq4qb06pd` (`driver_id`),
  ADD KEY `FKi25uh7hofdk6wc0wfet17u1n6` (`expense_id`),
  ADD KEY `FK7ugum3nkdq5cehfomsb57oa70` (`expense_detail_id`),
  ADD KEY `FKacled0h7m3j5pxgh4xuhy9rbc` (`truck_tractor_id`);

--
-- Indexes for table `tb_petty_cash_master`
--
ALTER TABLE `tb_petty_cash_master`
  ADD PRIMARY KEY (`petty_cash_no`),
  ADD KEY `FKsl5atpvbkp4w4gk406vb0ypkb` (`accounting_id`),
  ADD KEY `FK60gwnqarh4t7xrstlskt80cpd` (`driver_id`),
  ADD KEY `FK2nj09f0gx0ky5rpfh58mpr0r4` (`project_id`),
  ADD KEY `FK2k7mla8o544q4v6wwtscte310` (`payer_id`);

--
-- Indexes for table `tb_preventive`
--
ALTER TABLE `tb_preventive`
  ADD PRIMARY KEY (`code`),
  ADD KEY `FKslgg2u3jo1l371tr6pkd9ytf8` (`yard_id`),
  ADD KEY `FKgyc7ektpv8b36uae96w135ui2` (`driver_id`),
  ADD KEY `FK5ml8orv6q1ocnf2sdlq61yslf` (`master_preventive_setup_item_id`),
  ADD KEY `FK99p1vl0vlrierimxq622kmaof` (`truck_profile_id`);

--
-- Indexes for table `tb_preventive_item`
--
ALTER TABLE `tb_preventive_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK6b910tydqck3oobquprws3ko4` (`preventive_code`);

--
-- Indexes for table `tb_preventive_spare_part`
--
ALTER TABLE `tb_preventive_spare_part`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKrxu7168aetxbofontwwnf25gn` (`ma_service_type_id`),
  ADD KEY `FK6m5fpcfusjfjf6inc0ljmdhri` (`preventive_code`),
  ADD KEY `FKadqr75b4pt6yxj0ethcefaeu9` (`spare_parts_stock_id`);

--
-- Indexes for table `tb_price_edit_history`
--
ALTER TABLE `tb_price_edit_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_po_id` (`purchase_order_id`),
  ADD KEY `idx_po_item_id` (`purchase_order_item_id`),
  ADD KEY `idx_po_no` (`po_no`),
  ADD KEY `idx_edit_date` (`edit_date`),
  ADD KEY `idx_approved_by` (`approved_by`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_po_id_status` (`purchase_order_id`,`status`),
  ADD KEY `idx_po_item_id_status` (`purchase_order_item_id`,`status`);

--
-- Indexes for table `tb_project`
--
ALTER TABLE `tb_project`
  ADD PRIMARY KEY (`PROJECT_ID`);

--
-- Indexes for table `tb_project_name`
--
ALTER TABLE `tb_project_name`
  ADD PRIMARY KEY (`PROJECT_NAME_ID`);

--
-- Indexes for table `tb_province`
--
ALTER TABLE `tb_province`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_purchase_order`
--
ALTER TABLE `tb_purchase_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_po_no` (`po_no`),
  ADD KEY `idx_po_status` (`status`),
  ADD KEY `idx_po_date` (`po_date`),
  ADD KEY `idx_po_vendor` (`vendor_id`),
  ADD KEY `idx_po_requester` (`requester_id`),
  ADD KEY `FK9l15tne6qysiqi0g589y9lavf` (`approver_id`),
  ADD KEY `FKl36bh8n1kntehy2g9j6ksoljf` (`checker_id`),
  ADD KEY `FK4aawm32xmv0k9anw3so0e6r1m` (`pr_id`);

--
-- Indexes for table `tb_purchase_order_item`
--
ALTER TABLE `tb_purchase_order_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_po_item_po_id` (`po_id`),
  ADD KEY `idx_po_item_code` (`item_code`),
  ADD KEY `idx_po_item_pr_item` (`pr_item_id`),
  ADD KEY `FKiyb82gj4jt0fb1e276nhvvyto` (`sps_id`);

--
-- Indexes for table `tb_purchase_requisition`
--
ALTER TABLE `tb_purchase_requisition`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_pr_no` (`pr_no`),
  ADD KEY `idx_pr_date` (`pr_date`),
  ADD KEY `idx_pr_requester` (`requester_id`),
  ADD KEY `FK8hedun46pqjijtmxyocce9ii8` (`approver_id`),
  ADD KEY `FKngnqykbh5m5racj2vhwm6qptq` (`checker_id`),
  ADD KEY `FK4kt8ypybchskcmnrqwigvns7a` (`department_id`),
  ADD KEY `FKtj6so9v20iay85xh3d041w26l` (`vendor_id`),
  ADD KEY `FK2ei9vc9sqkn1y6b7lh1wl0hn5` (`yard_id`);

--
-- Indexes for table `tb_purchase_requisition_item`
--
ALTER TABLE `tb_purchase_requisition_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pr_item_pr_id` (`pr_id`),
  ADD KEY `idx_pr_item_code` (`item_code`),
  ADD KEY `FKrmyyo82x39rb29ww3npderksa` (`sps_id`),
  ADD KEY `FK9t3ee7vy799j3cer5me4xvnn1` (`yard_id`),
  ADD KEY `idx_pr_item_stock_qty_at_request` (`stock_quantity_at_request`);

--
-- Indexes for table `tb_purchase_return`
--
ALTER TABLE `tb_purchase_return`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_prn_no` (`prn_no`),
  ADD KEY `idx_return_date` (`return_date`),
  ADD KEY `idx_return_requester` (`return_requester_id`),
  ADD KEY `idx_vendor` (`vendor_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_department` (`department_id`),
  ADD KEY `idx_yard` (`yard_id`),
  ADD KEY `FKk2m58aji2qhgjxe0gny3t214v` (`approver_id`),
  ADD KEY `FKpa335jgle8b12hsn5qr153rpq` (`checker_id`);

--
-- Indexes for table `tb_purchase_return_item`
--
ALTER TABLE `tb_purchase_return_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prn_item_prn_id` (`prn_id`),
  ADD KEY `idx_prn_item_code` (`item_code`),
  ADD KEY `idx_prn_spare_parts_stock` (`spare_parts_stock_id`),
  ADD KEY `idx_prn_spare_parts_stock_detail` (`spare_parts_stock_detail_id`),
  ADD KEY `idx_prn_status` (`status`);

--
-- Indexes for table `tb_quotation`
--
ALTER TABLE `tb_quotation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKeqpinpautpyk4prfv87xigvhh` (`customer_id`),
  ADD KEY `FKiev00ji1y7ea2e55iduh05uux` (`user_id`);

--
-- Indexes for table `tb_quotation_item`
--
ALTER TABLE `tb_quotation_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKrxmbrx9cuq0hmm8ad21kdfr7x` (`route_id`),
  ADD KEY `FKm7apxjfs190mtjk0wtgdq9nbs` (`truck_type_id`),
  ADD KEY `FK535tymbp5p9ss2sshboskj33m` (`quotation_id`);

--
-- Indexes for table `tb_quotation_rate`
--
ALTER TABLE `tb_quotation_rate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKi84sek6awmuur16hes2684ymo` (`quotation_item_id`);

--
-- Indexes for table `tb_receipt_item_ia`
--
ALTER TABLE `tb_receipt_item_ia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKn5ee91lqcho0inor55ubt3uwk` (`receipt_id`);

--
-- Indexes for table `tb_receipt_master`
--
ALTER TABLE `tb_receipt_master`
  ADD PRIMARY KEY (`receipt_no`),
  ADD KEY `FKqp26o2a1j808q7twugxtei58m` (`job_type_id`),
  ADD KEY `FKs84t1qh64o8cf7yvttmwn7bsx` (`project_id`),
  ADD KEY `FK6lxtore1x0p9yqker0a9d9dag` (`customer_id`);

--
-- Indexes for table `tb_receipt_ra_master`
--
ALTER TABLE `tb_receipt_ra_master`
  ADD PRIMARY KEY (`receipt_ra_no`),
  ADD KEY `FKcqg7idypbnir2xm0qb82efg2u` (`job_type_id`),
  ADD KEY `FKp7r61jwwg0ntflvukrw2fpuik` (`project_id`),
  ADD KEY `FKec4cfbp3aebl9bq4d4wr69qpn` (`customer_id`);

--
-- Indexes for table `tb_role`
--
ALTER TABLE `tb_role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `tb_roles`
--
ALTER TABLE `tb_roles`
  ADD PRIMARY KEY (`roleId`);

--
-- Indexes for table `tb_route_detail`
--
ALTER TABLE `tb_route_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKl290vm3vkl9p5ckh4joi7k37u` (`route_id`),
  ADD KEY `FKri6tvmeemotuoi9hw8oo603qa` (`gsdb_id`),
  ADD KEY `ix_route_dtl` (`route_id`,`gsdb_id`,`status`);

--
-- Indexes for table `tb_route_master`
--
ALTER TABLE `tb_route_master`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKkjyvi5hic1bogxf9q289rg176` (`customer_id`),
  ADD KEY `FKbra0jqa1heg9jstu7oyipj5g5` (`project_id`),
  ADD KEY `FKq2u1h2v4lbqancsagwa7773kb` (`job_type_id`);

--
-- Indexes for table `tb_route_truck_cost`
--
ALTER TABLE `tb_route_truck_cost`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKmwgypu7gwiyqns9iww6ftrith` (`truck_cost_detail_id`),
  ADD KEY `FKql5fgv90stjbivprhr4y9ul89` (`truck_cost_id`);

--
-- Indexes for table `tb_route_truck_type`
--
ALTER TABLE `tb_route_truck_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK96qhjyfnhd320yjkt80w9wbua` (`truck_type_id`);

--
-- Indexes for table `tb_running_no`
--
ALTER TABLE `tb_running_no`
  ADD PRIMARY KEY (`type`,`year`,`month`) USING BTREE,
  ADD UNIQUE KEY `UK_running_no_type_year_month` (`type`,`year`,`month`),
  ADD KEY `IDX_running_no_lookup` (`type`,`year`,`month`),
  ADD KEY `IDX_running_no_type` (`type`);

--
-- Indexes for table `tb_running_no_day`
--
ALTER TABLE `tb_running_no_day`
  ADD PRIMARY KEY (`day`,`month`,`type`,`year`);

--
-- Indexes for table `tb_safety`
--
ALTER TABLE `tb_safety`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK91x1hooela6pqqnq240qln01n` (`accident_area_type_id`),
  ADD KEY `FKeq0065omspbd8w4apl4n9rj1n` (`accident_type_id`),
  ADD KEY `FKlqpqwnrsokck80r98lnucrr5s` (`car_ins_broker_id`),
  ADD KEY `FKr7nto7ga0ggq79mq3fqa0o1go` (`driver_id`),
  ADD KEY `FKsrla6gqiro45pi0bsa8yuqprf` (`fault_acident_type_id`),
  ADD KEY `FKljc7vxx5a9g5484sbt10m028y` (`job_id`),
  ADD KEY `FKe5cqraipdias6yd5qbneto39` (`ma_id`),
  ADD KEY `FKe6kblaavb3rqfr4t379rfkrwn` (`product_ins_broker_id`),
  ADD KEY `FK698qdevahgym3gt5jqihdjynf` (`truck_profile_id`),
  ADD KEY `FKdtkkse4t3fg2cdmo5cl8sto43` (`manager_id`),
  ADD KEY `FKsej5k0ccqmb0n79wlpa04wu8i` (`car_ins_company_id`),
  ADD KEY `FKdebycb9665hfh7r7x4x7cyff8` (`product_ins_company_id`);

--
-- Indexes for table `tb_safety2021_2023`
--
ALTER TABLE `tb_safety2021_2023`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK91x1hooela6pqqnq240qln01n` (`accident_area_type_id`),
  ADD KEY `FKeq0065omspbd8w4apl4n9rj1n` (`accident_type_id`),
  ADD KEY `FKlqpqwnrsokck80r98lnucrr5s` (`car_ins_broker_id`),
  ADD KEY `FKr7nto7ga0ggq79mq3fqa0o1go` (`driver_id`),
  ADD KEY `FKsrla6gqiro45pi0bsa8yuqprf` (`fault_acident_type_id`),
  ADD KEY `FKljc7vxx5a9g5484sbt10m028y` (`job_id`),
  ADD KEY `FKe5cqraipdias6yd5qbneto39` (`ma_id`),
  ADD KEY `FKe6kblaavb3rqfr4t379rfkrwn` (`product_ins_broker_id`),
  ADD KEY `FK698qdevahgym3gt5jqihdjynf` (`truck_profile_id`),
  ADD KEY `FKdtkkse4t3fg2cdmo5cl8sto43` (`manager_id`),
  ADD KEY `FKsej5k0ccqmb0n79wlpa04wu8i` (`car_ins_company_id`),
  ADD KEY `FKdebycb9665hfh7r7x4x7cyff8` (`product_ins_company_id`);

--
-- Indexes for table `tb_safety_attachment`
--
ALTER TABLE `tb_safety_attachment`
  ADD PRIMARY KEY (`attachment_no`),
  ADD KEY `FK4xlv6beqnd3sa2cflkgtpi3dg` (`safety_id`),
  ADD KEY `FK8fvay7u5gptskduxamp13b16a` (`safety_attachment_type_id`);

--
-- Indexes for table `tb_safety_attachment2021_2023`
--
ALTER TABLE `tb_safety_attachment2021_2023`
  ADD PRIMARY KEY (`attachment_no`),
  ADD KEY `FK4xlv6beqnd3sa2cflkgtpi3dg` (`safety_id`),
  ADD KEY `FK8fvay7u5gptskduxamp13b16a` (`safety_attachment_type_id`);

--
-- Indexes for table `tb_safety_attachment_type`
--
ALTER TABLE `tb_safety_attachment_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_sale_type`
--
ALTER TABLE `tb_sale_type`
  ADD PRIMARY KEY (`SALE_TYPE_ID`);

--
-- Indexes for table `tb_setstopeta`
--
ALTER TABLE `tb_setstopeta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_sl_service_ctrl`
--
ALTER TABLE `tb_sl_service_ctrl`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `tb_spare_parts`
--
ALTER TABLE `tb_spare_parts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1p2uqoqw3tvhu68cy3dtt40se` (`spare_parts_type_id`);

--
-- Indexes for table `tb_spare_parts_stock`
--
ALTER TABLE `tb_spare_parts_stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKbdnhotac78nosf5gogwc2u2s6` (`yard_id`),
  ADD KEY `FKhlquh0iade2v48r0p4i1ux6lu` (`spare_parts_id`),
  ADD KEY `FKc0dun98k0suc5mlqrwg24ehh9` (`spare_parts_type_id`),
  ADD KEY `FKri4gwlxx5v9cmyg0qm667nf69` (`master_spare_part_unit_id`);

--
-- Indexes for table `tb_spare_parts_stock_detail`
--
ALTER TABLE `tb_spare_parts_stock_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK2v0m8n5os9ru2t06ct655icpe` (`spare_parts_stock_id`),
  ADD KEY `FKti4hm49kkqy2kkt4m2p7esrmh` (`move_stock_id`),
  ADD KEY `idx_sps_detail_grn` (`grn_id`);

--
-- Indexes for table `tb_spare_parts_type`
--
ALTER TABLE `tb_spare_parts_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_sr_master`
--
ALTER TABLE `tb_sr_master`
  ADD PRIMARY KEY (`sr_no`),
  ADD KEY `FKdvf43oam1ep751wlbemadxtr9` (`customer_id`);

--
-- Indexes for table `tb_stake_holder_attachment`
--
ALTER TABLE `tb_stake_holder_attachment`
  ADD PRIMARY KEY (`attachment_no`),
  ADD KEY `FKsdqf7h533s8m1mkfu9k4o0d0c` (`stake_holder_id`);

--
-- Indexes for table `tb_stake_holder_master`
--
ALTER TABLE `tb_stake_holder_master`
  ADD PRIMARY KEY (`STAKE_HOLDER_UN_ID`),
  ADD KEY `FKe0k47440e25qdstbk65xwj98` (`customer_id`),
  ADD KEY `FK227cx8vewsgyp84u3lxkeyp40` (`STAKE_HOLDER_PROJECT`),
  ADD KEY `FKdj09nxpre9awdpn9infoqy29r` (`STAKE_HOLDER_SALE_TYPE`),
  ADD KEY `FKs2nrfmg08uvow9ph7y4ru38rn` (`STAKE_HOLDER_PROVINCE_ID`),
  ADD KEY `FKis445ie62wl5by3ekm5fcu1d3` (`STAKE_HOLDER_CREDIT_TERM`),
  ADD KEY `FKcmnndxbtv9d5y600sxv6emmwa` (`STAKE_HOLDER_PAYMENT_METHOD`);

--
-- Indexes for table `tb_sys_menu`
--
ALTER TABLE `tb_sys_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_sys_permission`
--
ALTER TABLE `tb_sys_permission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_tire_history`
--
ALTER TABLE `tb_tire_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tire_id` (`tire_id`),
  ADD KEY `idx_change_type` (`change_type`),
  ADD KEY `idx_changed_date` (`changed_date`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_tire_id_status` (`tire_id`,`status`),
  ADD KEY `idx_change_type_status` (`change_type`,`status`),
  ADD KEY `FK33jkovtdgyn6qt47ya101witm` (`new_parent_id`),
  ADD KEY `FKpxnubncb4pykrgvds8ekuoxtv` (`old_parent_id`);

--
-- Indexes for table `tb_tire_return_stock`
--
ALTER TABLE `tb_tire_return_stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKmwkixan29xpb809oxa72s4o5w` (`maintenance_tire_id`);

--
-- Indexes for table `tb_truck`
--
ALTER TABLE `tb_truck`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_truck_cost_detail`
--
ALTER TABLE `tb_truck_cost_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_truck_cost_master`
--
ALTER TABLE `tb_truck_cost_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_truck_profile`
--
ALTER TABLE `tb_truck_profile`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `tb_trucknumber_ibfk_1` (`TRUCK_TYPE`),
  ADD KEY `GPS_TRUCK` (`GPS_TYPE_ID`),
  ADD KEY `ACT_NO` (`ACT_ID`),
  ADD KEY `POLICY_NO` (`POLICY_ID`),
  ADD KEY `FLEETCARD_NO` (`FLEETCARD_ID`),
  ADD KEY `SUPPLIER_CODE` (`SUPPLIER_SUM`),
  ADD KEY `FKjmvdxop08i4xv1h4jmy5s71ko` (`PROJECT_ID`),
  ADD KEY `FKifs9yc0bioda1kfwisvmnk6vh` (`TRUCK_PROVINCE_ID`),
  ADD KEY `FKjdnncy8c793wvsdsoei6ctiq6` (`COMPANY`),
  ADD KEY `FK9f6lk80sb78udy96r6tdjhbt` (`Yard_Id`),
  ADD KEY `ix_truck_profile` (`BRAND`,`FUEL_TYPE`),
  ADD KEY `idx_truck_profile_yard_project` (`Yard_Id`,`PROJECT_ID`);

--
-- Indexes for table `tb_truck_profile_attachment`
--
ALTER TABLE `tb_truck_profile_attachment`
  ADD PRIMARY KEY (`attachment_no`),
  ADD KEY `FK9dbl9d9uysfg6cdbwd8743ft4` (`truck_profile_id`),
  ADD KEY `FKm0b9sedjdfmxqptsod2p3mwjq` (`truck_profile_attachment_type_id`);

--
-- Indexes for table `tb_truck_profile_attachment_type`
--
ALTER TABLE `tb_truck_profile_attachment_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_truck_profile_image`
--
ALTER TABLE `tb_truck_profile_image`
  ADD PRIMARY KEY (`image_no`),
  ADD KEY `FK7galse0berfou0usftdcc7fcs` (`truck_profile_id`),
  ADD KEY `FKtm1pkrpl8wf52yteln23t8qgv` (`truck_profile_image_type_id`);

--
-- Indexes for table `tb_truck_profile_image_type`
--
ALTER TABLE `tb_truck_profile_image_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_truck_type`
--
ALTER TABLE `tb_truck_type`
  ADD PRIMARY KEY (`TYPE_ID`);

--
-- Indexes for table `tb_truck_waiting_status`
--
ALTER TABLE `tb_truck_waiting_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_truck_waiting_status_date` (`truck_profile_id`,`status_date`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`Id`,`username`),
  ADD KEY `FKqphgwitgf4n7a0w8v488nnlts` (`company_id`),
  ADD KEY `FKo0iqymuvbpk88ghcs7syg3vax` (`department_id`),
  ADD KEY `FKel0ole1gwx1oxx1o2jfg0tcx9` (`position_id`),
  ADD KEY `FKe5iaii1jr1kkyuvlar75n7n92` (`section_id`),
  ADD KEY `FK892ogvj4mdm0reg5xap2983tb` (`status_id`),
  ADD KEY `FKhi0v5imh3jb2wh8j5j8q3ndvy` (`title_id`),
  ADD KEY `FKlesqlrptevam99hb7287ralg6` (`type_id`),
  ADD KEY `FKn4pia86jdp765e8xccw2e7n5s` (`yard_id`),
  ADD KEY `FKdif88hhuupydh4u0incn9rtvl` (`emp_comp_id`),
  ADD KEY `FKgkf20gvsqfed6jpvbd9j2t8lv` (`emp_dpm_id`),
  ADD KEY `FKfcn2599uuym0asvv15ara0ikr` (`emp_position_id`),
  ADD KEY `FKbrxnovvafef2xyc7qw7kj6mk2` (`emp_section_id`),
  ADD KEY `FKjivp2ksdjydsxv0ocgg4pfskp` (`emp_type_id`),
  ADD KEY `FKsx06yyxoaecbnl7dr02jbmfsx` (`education_id`),
  ADD KEY `FKs6efvsl2ssefeu6w3j4e9u24v` (`idcard_addr_province_id`),
  ADD KEY `FK1dll2gl2ns2lv5b1rdb2vf2ht` (`idcard_issued_province_id`),
  ADD KEY `FKnpwd46j21x9atrsx9onxwdrw3` (`present_addr_bank_id`),
  ADD KEY `FK7fh9iiiuh2a2pg4cxnet5pe42` (`present_addr_province_id`),
  ADD KEY `FKe8x5gkmnqrat5inv546q00w8o` (`gender_id`),
  ADD KEY `FK683cwgqdbbg9tqv0w6uuyjwh9` (`nationality_id`),
  ADD KEY `FKt4713a85a0v9gp3qyjcw4oeh2` (`race_id`),
  ADD KEY `FKmdny98dr1543qqtmqpn71y0s9` (`religion_id`),
  ADD KEY `FK3t30scykia7ngamcyf7nxs5vn` (`cust_company_id`);

--
-- Indexes for table `tb_users_roles`
--
ALTER TABLE `tb_users_roles`
  ADD KEY `FKariud4fp9diekkpe7upfn77mq` (`role_id`),
  ADD KEY `FK85qorv8qojsxvl1nv56vckxmj` (`user_id`);

--
-- Indexes for table `tb_user_attachment`
--
ALTER TABLE `tb_user_attachment`
  ADD PRIMARY KEY (`attachment_no`),
  ADD KEY `FK14w1wsodhcbpotffmthjvrca6` (`user_id`);

--
-- Indexes for table `tb_user_company`
--
ALTER TABLE `tb_user_company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user_department`
--
ALTER TABLE `tb_user_department`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user_gender`
--
ALTER TABLE `tb_user_gender`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `tb_user_image`
--
ALTER TABLE `tb_user_image`
  ADD PRIMARY KEY (`image_no`),
  ADD KEY `FKpjsp39m1pa1vn3p2qryw4ak90` (`user_id`);

--
-- Indexes for table `tb_user_menu`
--
ALTER TABLE `tb_user_menu`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `tb_user_nationality`
--
ALTER TABLE `tb_user_nationality`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `tb_user_position`
--
ALTER TABLE `tb_user_position`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user_religion`
--
ALTER TABLE `tb_user_religion`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `tb_user_role`
--
ALTER TABLE `tb_user_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user_role_menu`
--
ALTER TABLE `tb_user_role_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user_section`
--
ALTER TABLE `tb_user_section`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user_status`
--
ALTER TABLE `tb_user_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user_title`
--
ALTER TABLE `tb_user_title`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user_type`
--
ALTER TABLE `tb_user_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user_yard`
--
ALTER TABLE `tb_user_yard`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_accident_area_type`
--
ALTER TABLE `tb_accident_area_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_accident_type`
--
ALTER TABLE `tb_accident_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_advance_payment_master`
--
ALTER TABLE `tb_advance_payment_master`
  MODIFY `advance_payment_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_carrier`
--
ALTER TABLE `tb_carrier`
  MODIFY `carrierID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_city`
--
ALTER TABLE `tb_city`
  MODIFY `cityID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_container_size`
--
ALTER TABLE `tb_container_size`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_credit_term`
--
ALTER TABLE `tb_credit_term`
  MODIFY `CREDIT_TERM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_department`
--
ALTER TABLE `tb_department`
  MODIFY `departmentId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_driver_leave`
--
ALTER TABLE `tb_driver_leave`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_emp_company`
--
ALTER TABLE `tb_emp_company`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_emp_department`
--
ALTER TABLE `tb_emp_department`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_emp_position`
--
ALTER TABLE `tb_emp_position`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_emp_section`
--
ALTER TABLE `tb_emp_section`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_emp_type`
--
ALTER TABLE `tb_emp_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_expense_detail`
--
ALTER TABLE `tb_expense_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_expense_master`
--
ALTER TABLE `tb_expense_master`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_fault_accident_type`
--
ALTER TABLE `tb_fault_accident_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_fleet_card`
--
ALTER TABLE `tb_fleet_card`
  MODIFY `FLEETCARD_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_fuel_input`
--
ALTER TABLE `tb_fuel_input`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_gas_station`
--
ALTER TABLE `tb_gas_station`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_goods_receipt_note`
--
ALTER TABLE `tb_goods_receipt_note`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_goods_receipt_note_item`
--
ALTER TABLE `tb_goods_receipt_note_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_goods_receipt_note_sub_item`
--
ALTER TABLE `tb_goods_receipt_note_sub_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_gps_type`
--
ALTER TABLE `tb_gps_type`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_gsdb_code`
--
ALTER TABLE `tb_gsdb_code`
  MODIFY `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_gsdb_delivery_type`
--
ALTER TABLE `tb_gsdb_delivery_type`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_history_tire`
--
ALTER TABLE `tb_history_tire`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_income_type`
--
ALTER TABLE `tb_income_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_insurance_act`
--
ALTER TABLE `tb_insurance_act`
  MODIFY `ACT_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_insurance_cover_product`
--
ALTER TABLE `tb_insurance_cover_product`
  MODIFY `POLICY_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_invoice_excel_group`
--
ALTER TABLE `tb_invoice_excel_group`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_invoice_excel_mapping`
--
ALTER TABLE `tb_invoice_excel_mapping`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_invoice_item`
--
ALTER TABLE `tb_invoice_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_cost`
--
ALTER TABLE `tb_job_cost`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_cost2021_2023`
--
ALTER TABLE `tb_job_cost2021_2023`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_fuel`
--
ALTER TABLE `tb_job_fuel`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_fuel2021_2023`
--
ALTER TABLE `tb_job_fuel2021_2023`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_income`
--
ALTER TABLE `tb_job_income`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_income2021_2023`
--
ALTER TABLE `tb_job_income2021_2023`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_master`
--
ALTER TABLE `tb_job_master`
  MODIFY `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_master2021_2023`
--
ALTER TABLE `tb_job_master2021_2023`
  MODIFY `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_notification`
--
ALTER TABLE `tb_job_notification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_job_order_template_download`
--
ALTER TABLE `tb_job_order_template_download`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_job_reserve_payment`
--
ALTER TABLE `tb_job_reserve_payment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_reserve_payment2021_2023`
--
ALTER TABLE `tb_job_reserve_payment2021_2023`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_route`
--
ALTER TABLE `tb_job_route`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_job_route2021_2023`
--
ALTER TABLE `tb_job_route2021_2023`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_load`
--
ALTER TABLE `tb_load`
  MODIFY `loadID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_loadstop`
--
ALTER TABLE `tb_loadstop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_lock_report_ctrl`
--
ALTER TABLE `tb_lock_report_ctrl`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_log_advance_payment_master`
--
ALTER TABLE `tb_log_advance_payment_master`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_log_allowance_master`
--
ALTER TABLE `tb_log_allowance_master`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_log_invoice_master`
--
ALTER TABLE `tb_log_invoice_master`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_log_job_cost`
--
ALTER TABLE `tb_log_job_cost`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_log_job_master`
--
ALTER TABLE `tb_log_job_master`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_log_job_route`
--
ALTER TABLE `tb_log_job_route`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_log_receipt_master`
--
ALTER TABLE `tb_log_receipt_master`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_log_receipt_ra_master`
--
ALTER TABLE `tb_log_receipt_ra_master`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_log_sr_master`
--
ALTER TABLE `tb_log_sr_master`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_maintenance`
--
ALTER TABLE `tb_maintenance`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_maintenance_preventive`
--
ALTER TABLE `tb_maintenance_preventive`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_maintenance_service_cost`
--
ALTER TABLE `tb_maintenance_service_cost`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_maintenance_spare_part`
--
ALTER TABLE `tb_maintenance_spare_part`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_maintenance_tire`
--
ALTER TABLE `tb_maintenance_tire`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_masteryard`
--
ALTER TABLE `tb_masteryard`
  MODIFY `Yard_Id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_master_maintenance_service_cost_type`
--
ALTER TABLE `tb_master_maintenance_service_cost_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_master_preventive_checklist`
--
ALTER TABLE `tb_master_preventive_checklist`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_master_preventive_mainsystem`
--
ALTER TABLE `tb_master_preventive_mainsystem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_master_preventive_setup`
--
ALTER TABLE `tb_master_preventive_setup`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_master_preventive_setup_detail`
--
ALTER TABLE `tb_master_preventive_setup_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_master_preventive_setup_item`
--
ALTER TABLE `tb_master_preventive_setup_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_master_spare_part_unit`
--
ALTER TABLE `tb_master_spare_part_unit`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_menu`
--
ALTER TABLE `tb_menu`
  MODIFY `menu_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_move_stock`
--
ALTER TABLE `tb_move_stock`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_payment_method`
--
ALTER TABLE `tb_payment_method`
  MODIFY `PAYMENT_METHOD_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_permission`
--
ALTER TABLE `tb_permission`
  MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_petty_cash_cost`
--
ALTER TABLE `tb_petty_cash_cost`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_preventive_item`
--
ALTER TABLE `tb_preventive_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_preventive_spare_part`
--
ALTER TABLE `tb_preventive_spare_part`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_price_edit_history`
--
ALTER TABLE `tb_price_edit_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_project`
--
ALTER TABLE `tb_project`
  MODIFY `PROJECT_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_project_name`
--
ALTER TABLE `tb_project_name`
  MODIFY `PROJECT_NAME_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_purchase_order`
--
ALTER TABLE `tb_purchase_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_purchase_order_item`
--
ALTER TABLE `tb_purchase_order_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_purchase_requisition`
--
ALTER TABLE `tb_purchase_requisition`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_purchase_requisition_item`
--
ALTER TABLE `tb_purchase_requisition_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_purchase_return`
--
ALTER TABLE `tb_purchase_return`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_purchase_return_item`
--
ALTER TABLE `tb_purchase_return_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_quotation`
--
ALTER TABLE `tb_quotation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_quotation_item`
--
ALTER TABLE `tb_quotation_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_receipt_item_ia`
--
ALTER TABLE `tb_receipt_item_ia`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_roles`
--
ALTER TABLE `tb_roles`
  MODIFY `roleId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_safety`
--
ALTER TABLE `tb_safety`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_safety2021_2023`
--
ALTER TABLE `tb_safety2021_2023`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_safety_attachment_type`
--
ALTER TABLE `tb_safety_attachment_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_sale_type`
--
ALTER TABLE `tb_sale_type`
  MODIFY `SALE_TYPE_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_setstopeta`
--
ALTER TABLE `tb_setstopeta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_sl_service_ctrl`
--
ALTER TABLE `tb_sl_service_ctrl`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_spare_parts`
--
ALTER TABLE `tb_spare_parts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_spare_parts_stock`
--
ALTER TABLE `tb_spare_parts_stock`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_spare_parts_stock_detail`
--
ALTER TABLE `tb_spare_parts_stock_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_spare_parts_type`
--
ALTER TABLE `tb_spare_parts_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_stake_holder_master`
--
ALTER TABLE `tb_stake_holder_master`
  MODIFY `STAKE_HOLDER_UN_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_sys_menu`
--
ALTER TABLE `tb_sys_menu`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_sys_permission`
--
ALTER TABLE `tb_sys_permission`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_tire_history`
--
ALTER TABLE `tb_tire_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_tire_return_stock`
--
ALTER TABLE `tb_tire_return_stock`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_truck_profile`
--
ALTER TABLE `tb_truck_profile`
  MODIFY `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_truck_profile_attachment_type`
--
ALTER TABLE `tb_truck_profile_attachment_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_truck_profile_image_type`
--
ALTER TABLE `tb_truck_profile_image_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_truck_type`
--
ALTER TABLE `tb_truck_type`
  MODIFY `TYPE_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_truck_waiting_status`
--
ALTER TABLE `tb_truck_waiting_status`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'PK';

--
-- AUTO_INCREMENT for table `tb_user_company`
--
ALTER TABLE `tb_user_company`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_user_department`
--
ALTER TABLE `tb_user_department`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_user_position`
--
ALTER TABLE `tb_user_position`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_user_role`
--
ALTER TABLE `tb_user_role`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_user_role_menu`
--
ALTER TABLE `tb_user_role_menu`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_user_section`
--
ALTER TABLE `tb_user_section`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_user_status`
--
ALTER TABLE `tb_user_status`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_user_title`
--
ALTER TABLE `tb_user_title`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_user_type`
--
ALTER TABLE `tb_user_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_user_yard`
--
ALTER TABLE `tb_user_yard`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `qrtz_blob_triggers`
--
ALTER TABLE `qrtz_blob_triggers`
  ADD CONSTRAINT `qrtz_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

--
-- Constraints for table `qrtz_cron_triggers`
--
ALTER TABLE `qrtz_cron_triggers`
  ADD CONSTRAINT `qrtz_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

--
-- Constraints for table `qrtz_simple_triggers`
--
ALTER TABLE `qrtz_simple_triggers`
  ADD CONSTRAINT `qrtz_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

--
-- Constraints for table `qrtz_simprop_triggers`
--
ALTER TABLE `qrtz_simprop_triggers`
  ADD CONSTRAINT `qrtz_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

--
-- Constraints for table `qrtz_triggers`
--
ALTER TABLE `qrtz_triggers`
  ADD CONSTRAINT `qrtz_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`);

--
-- Constraints for table `tb_advance_payment_master`
--
ALTER TABLE `tb_advance_payment_master`
  ADD CONSTRAINT `FK1309fbmjhepc5bdf8e2kyv5wd` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`),
  ADD CONSTRAINT `FKi8l86tr6dig0ergx19qxbmgfc` FOREIGN KEY (`received_by_id`) REFERENCES `tb_user` (`Id`);

--
-- Constraints for table `tb_allowance_master`
--
ALTER TABLE `tb_allowance_master`
  ADD CONSTRAINT `FK4xi8398e0vjycls7vk4putkub` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`),
  ADD CONSTRAINT `FK9oer8p1yeggwdvstk4fadxki1` FOREIGN KEY (`driver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKb8r3fxt4g5pdmn7ftow8isesn` FOREIGN KEY (`truck_tractor_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKqka81brntuydun7utffn3s8hi` FOREIGN KEY (`job_type_id`) REFERENCES `tb_job_type` (`id`);

--
-- Constraints for table `tb_allowance_sub_master`
--
ALTER TABLE `tb_allowance_sub_master`
  ADD CONSTRAINT `FK6930ur8u2w2xtuqj9xip427a3` FOREIGN KEY (`job_type_id`) REFERENCES `tb_job_type` (`id`),
  ADD CONSTRAINT `FK6g4jhod8vhm45ehdpojjtpx0r` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`),
  ADD CONSTRAINT `FKqpkxjdvyd60dcefyesn35o6wx` FOREIGN KEY (`supplier_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`);

--
-- Constraints for table `tb_customer_attachment`
--
ALTER TABLE `tb_customer_attachment`
  ADD CONSTRAINT `FK7iscci07slgshi9p9tctce4ed` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`Id`);

--
-- Constraints for table `tb_cust_job_type`
--
ALTER TABLE `tb_cust_job_type`
  ADD CONSTRAINT `FKawm0a19iakc4rhqfei3qo7f15` FOREIGN KEY (`cust_user_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKrvslda4b4qqlgiypnsiwkfhw7` FOREIGN KEY (`job_type_id`) REFERENCES `tb_job_type` (`id`);

--
-- Constraints for table `tb_cust_project`
--
ALTER TABLE `tb_cust_project`
  ADD CONSTRAINT `FK6l6399uq9ujdrvll1i6k4kxxo` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`),
  ADD CONSTRAINT `FK7jqcyr2jj38eb9ovvf7xktwel` FOREIGN KEY (`cust_user_id`) REFERENCES `tb_user` (`Id`);

--
-- Constraints for table `tb_expense_detail`
--
ALTER TABLE `tb_expense_detail`
  ADD CONSTRAINT `FK6omniivl5m7yf73inkh1k3jbm` FOREIGN KEY (`expense_id`) REFERENCES `tb_expense_master` (`id`);

--
-- Constraints for table `tb_fuel_input`
--
ALTER TABLE `tb_fuel_input`
  ADD CONSTRAINT `FKas2bmrpso4bvlfdd99na6hfwe` FOREIGN KEY (`truck_tractor_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKmgsxc937mn62n3gouxi7gqthp` FOREIGN KEY (`driver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKno6k203ndejoojg1a2mgki5r0` FOREIGN KEY (`gas_station_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`);

--
-- Constraints for table `tb_goods_receipt_note`
--
ALTER TABLE `tb_goods_receipt_note`
  ADD CONSTRAINT `FK31srxg00u3rp1drxprx0pjwso` FOREIGN KEY (`purchase_order_id`) REFERENCES `tb_purchase_order` (`id`),
  ADD CONSTRAINT `FK4qaamc5flih00oee5xf54dtjo` FOREIGN KEY (`rejected_by`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKa1gqnq25q6lii1570pxtxfaxc` FOREIGN KEY (`vendor_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKcc7ervys41ggtt7ypqqwnqvjv` FOREIGN KEY (`approved_by`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKeha3j82qs6g1j2j9uqx7otvsh` FOREIGN KEY (`receiver_id`) REFERENCES `tb_user` (`Id`);

--
-- Constraints for table `tb_goods_receipt_note_item`
--
ALTER TABLE `tb_goods_receipt_note_item`
  ADD CONSTRAINT `FK3cgoegy3elwmwt9k5u7aaxrin` FOREIGN KEY (`purchase_order_item_id`) REFERENCES `tb_purchase_order_item` (`id`),
  ADD CONSTRAINT `FK53oo7693gacnpjvo4lve16iur` FOREIGN KEY (`po_item_id`) REFERENCES `tb_purchase_order_item` (`id`),
  ADD CONSTRAINT `FKiyn7yxgbjlc5mxjeagmof3lcx` FOREIGN KEY (`sps_id`) REFERENCES `tb_spare_parts_stock` (`id`),
  ADD CONSTRAINT `tb_goods_receipt_note_item_ibfk_1` FOREIGN KEY (`goods_receipt_note_id`) REFERENCES `tb_goods_receipt_note` (`id`);

--
-- Constraints for table `tb_goods_receipt_note_sub_item`
--
ALTER TABLE `tb_goods_receipt_note_sub_item`
  ADD CONSTRAINT `tb_goods_receipt_note_sub_item_ibfk_1` FOREIGN KEY (`goods_receipt_note_item_id`) REFERENCES `tb_goods_receipt_note_item` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tb_gsdb_code`
--
ALTER TABLE `tb_gsdb_code`
  ADD CONSTRAINT `FK3huq2bjfaey4392d7e3vhm3w7` FOREIGN KEY (`GSDB_PROVINCE_ID`) REFERENCES `tb_province` (`id`),
  ADD CONSTRAINT `FKkil38wo1lpsu6ct2y147j1adm` FOREIGN KEY (`GSDB_PROVINCE_ID`) REFERENCES `tb_province` (`id`);

--
-- Constraints for table `tb_history_tire`
--
ALTER TABLE `tb_history_tire`
  ADD CONSTRAINT `FK3sxf6qkyve7qttojy5ca767yv` FOREIGN KEY (`truck_profile_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FK6jwwffr8mo4596qw2wv81l4el` FOREIGN KEY (`maintenance_tire_id`) REFERENCES `tb_maintenance_tire` (`id`);

--
-- Constraints for table `tb_insurance_act`
--
ALTER TABLE `tb_insurance_act`
  ADD CONSTRAINT `FK2kdcu3hf3e5xs90gs2370bwwn` FOREIGN KEY (`ACT_RESPONSE_BY`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FK8afashd8j8rx82l3jrkx6cft8` FOREIGN KEY (`act_insurance_company`) REFERENCES `tb_insurance_company` (`id`),
  ADD CONSTRAINT `FK_tb_insurance_motor_tb_stake_holder_master` FOREIGN KEY (`ACT_RESPONSE_BY`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKeemffisw8on75k9xq1s0dyuar` FOREIGN KEY (`ACT_RESPONSE_BY`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKtrp6nx5n8myl04mgqy4y3i13k` FOREIGN KEY (`truck_id`) REFERENCES `tb_truck_profile` (`Id`);

--
-- Constraints for table `tb_insurance_cover_product`
--
ALTER TABLE `tb_insurance_cover_product`
  ADD CONSTRAINT `FK_tb_insurance_cover_product_tb_stake_holder_master` FOREIGN KEY (`INSURANCE_RESPONSE_BY`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKgyoi4qafd7h0ap4onobelgn4c` FOREIGN KEY (`insurance_company`) REFERENCES `tb_insurance_company` (`id`),
  ADD CONSTRAINT `FKr1un35iyqb3up7vvh1lcxmbvw` FOREIGN KEY (`INSURANCE_RESPONSE_BY`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKrv73scf9r9rh4yh1xgvbl3ag9` FOREIGN KEY (`truck_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKt7x3un4fegbmedu9d49lvkr3w` FOREIGN KEY (`INSURANCE_RESPONSE_BY`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`);

--
-- Constraints for table `tb_invoice_cover_master`
--
ALTER TABLE `tb_invoice_cover_master`
  ADD CONSTRAINT `FKc3x9l10lswg06m7c58tff4rwv` FOREIGN KEY (`customer_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKgl6w4j3p1baepx88bpd9i75ao` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`);

--
-- Constraints for table `tb_invoice_excel_mapping`
--
ALTER TABLE `tb_invoice_excel_mapping`
  ADD CONSTRAINT `FK9ff74ym1yqj49vtmi75cdb5cm` FOREIGN KEY (`invoice_excel_group_id`) REFERENCES `tb_invoice_excel_group` (`id`),
  ADD CONSTRAINT `FKlfjw3skxjtbh2axiew1qw4wjs` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`),
  ADD CONSTRAINT `FKpruq7wan08kib2vruhrn8y1ti` FOREIGN KEY (`job_type_id`) REFERENCES `tb_job_type` (`id`);

--
-- Constraints for table `tb_invoice_item`
--
ALTER TABLE `tb_invoice_item`
  ADD CONSTRAINT `FKoppj1caxn11093tw1rd6s1ju9` FOREIGN KEY (`invoice_id`) REFERENCES `tb_invoice_master` (`invoice_no`);

--
-- Constraints for table `tb_invoice_master`
--
ALTER TABLE `tb_invoice_master`
  ADD CONSTRAINT `FK88fgi16hfj4jtkopd7udhahlr` FOREIGN KEY (`job_type_id`) REFERENCES `tb_job_type` (`id`),
  ADD CONSTRAINT `FK8toldt0w77x6s115gglth2mdu` FOREIGN KEY (`customer_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKkjoo8g6tgstmf3h80nr2g5daq` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`);

--
-- Constraints for table `tb_job_cost`
--
ALTER TABLE `tb_job_cost`
  ADD CONSTRAINT `FK60nnnur1upiwacl6y5y54v12s` FOREIGN KEY (`job_id`) REFERENCES `tb_job_master` (`job_id`),
  ADD CONSTRAINT `FKcw1q1oo2arc9moof3nw6097cd` FOREIGN KEY (`truck_tractor_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKel2yjlbcosstxtwpewrjbl8jw` FOREIGN KEY (`truck_cost_detail_id`) REFERENCES `tb_truck_cost_detail` (`id`),
  ADD CONSTRAINT `FKem06mkdochqj86y2dubterspa` FOREIGN KEY (`truck_cost_id`) REFERENCES `tb_truck_cost_master` (`id`),
  ADD CONSTRAINT `FKjy3bsrlv3uacysxvagnah58o` FOREIGN KEY (`driver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKqpi7o6e45ol68lkkco8yu1itr` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKqprnoypxjnajc8oqmftketeoi` FOREIGN KEY (`supplier_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`);

--
-- Constraints for table `tb_job_fuel`
--
ALTER TABLE `tb_job_fuel`
  ADD CONSTRAINT `FK2visn36qbjp7ixkv388cb50fb` FOREIGN KEY (`gas_station_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FK4f7mmto3ce1brpu5ttqwu96r6` FOREIGN KEY (`job_route_id`) REFERENCES `tb_job_route` (`id`),
  ADD CONSTRAINT `FK6tn4dimd3xj14wft25ilho6pw` FOREIGN KEY (`truck_tractor_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKgie95vhrt6w1v94rt21595pkk` FOREIGN KEY (`job_id`) REFERENCES `tb_job_master` (`job_id`),
  ADD CONSTRAINT `FKm6o3yli3v3i2maeormpf0sm7p` FOREIGN KEY (`gsdb_id`) REFERENCES `tb_gsdb_code` (`Id`);

--
-- Constraints for table `tb_job_income`
--
ALTER TABLE `tb_job_income`
  ADD CONSTRAINT `FK5ab1wbjqvlttlhut5y28fw5sj` FOREIGN KEY (`income_type_id`) REFERENCES `tb_income_type` (`id`),
  ADD CONSTRAINT `FKe3ksq99efgpe8aaxf3tl15nbs` FOREIGN KEY (`job_id`) REFERENCES `tb_job_master` (`job_id`);

--
-- Constraints for table `tb_job_master`
--
ALTER TABLE `tb_job_master`
  ADD CONSTRAINT `FK1p1maj0i4spcpmv37dirf0eo2` FOREIGN KEY (`driver_id_2`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FK1q3gwty994egyx3yk4ln0svar` FOREIGN KEY (`customer_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FK2golmycpq4pgh6m6eede6j8do` FOREIGN KEY (`driver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FK3p9wg1m46hlfil5g1xaubyoja` FOREIGN KEY (`driver_id_4`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FK4u3wyadx9p07a5g7o7oei5qq5` FOREIGN KEY (`route_id`) REFERENCES `tb_route_master` (`id`),
  ADD CONSTRAINT `FKa55cdxf7yp5s150vu1i1me5oi` FOREIGN KEY (`truck_trailer_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKbl5rvdkkpbkt0f40kyy6k6ggl` FOREIGN KEY (`truck_type_id`) REFERENCES `tb_truck_type` (`TYPE_ID`),
  ADD CONSTRAINT `FKchyd9lhm34vog9k8jq5o7wngq` FOREIGN KEY (`container_size_id`) REFERENCES `tb_container_size` (`id`),
  ADD CONSTRAINT `FKkcyinxpkqrwhx6bn0b80lk0r3` FOREIGN KEY (`quotation_id`) REFERENCES `tb_quotation` (`id`),
  ADD CONSTRAINT `FKm4l41taxhry4qbovvqibxek49` FOREIGN KEY (`quotation_item_id`) REFERENCES `tb_quotation_item` (`id`),
  ADD CONSTRAINT `FKop4a4lkw2apspkpugtnrtxty1` FOREIGN KEY (`cost_truck_type_id`) REFERENCES `tb_truck_type` (`TYPE_ID`),
  ADD CONSTRAINT `FKrn498vfw0qos98m7o6vrla769` FOREIGN KEY (`driver_id_3`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKs145sqgutvaxgrmwd9h987sqd` FOREIGN KEY (`truck_tractor_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKt6p8wiggu43yj8x2cp1ah52o5` FOREIGN KEY (`route_truck_type_id`) REFERENCES `tb_route_truck_type` (`id`);

--
-- Constraints for table `tb_job_order_template_download`
--
ALTER TABLE `tb_job_order_template_download`
  ADD CONSTRAINT `tb_job_order_template_download_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`Id`) ON DELETE SET NULL;

--
-- Constraints for table `tb_job_reserve_payment`
--
ALTER TABLE `tb_job_reserve_payment`
  ADD CONSTRAINT `FK1ep6xxqi0a65eik0c295oo71` FOREIGN KEY (`truck_cost_detail_id`) REFERENCES `tb_truck_cost_detail` (`id`),
  ADD CONSTRAINT `FKeb3ltraetbcnypssy8g6fy765` FOREIGN KEY (`job_id`) REFERENCES `tb_job_master` (`job_id`),
  ADD CONSTRAINT `FKsti9wnq3gp3823016rpla302r` FOREIGN KEY (`advance_payment_id`) REFERENCES `tb_advance_payment_master` (`advance_payment_id`);

--
-- Constraints for table `tb_job_route`
--
ALTER TABLE `tb_job_route`
  ADD CONSTRAINT `FK45xiwy80fo6cddbbe0wo8u84i` FOREIGN KEY (`route_detail_id`) REFERENCES `tb_route_detail` (`id`),
  ADD CONSTRAINT `FK6ppy8fb74b5cqye3fq9w123yu` FOREIGN KEY (`job_id`) REFERENCES `tb_job_master` (`job_id`),
  ADD CONSTRAINT `FKc8aaub4s4ryhy5ddgq6ljro1x` FOREIGN KEY (`truck_tractor_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKd4u453jxe08j75nl291ln098a` FOREIGN KEY (`driver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKf2euicqgjpsnvyic683ye2jde` FOREIGN KEY (`truck_trailer_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKlanipl2vrqe0toly2t0a8m560` FOREIGN KEY (`gsdb_id2`) REFERENCES `tb_gsdb_code` (`Id`),
  ADD CONSTRAINT `FKs8qmtpkhn3nojnl4wcltoxh6i` FOREIGN KEY (`gsdb_id`) REFERENCES `tb_gsdb_code` (`Id`);

--
-- Constraints for table `tb_maintenance`
--
ALTER TABLE `tb_maintenance`
  ADD CONSTRAINT `FK6rda4oy87pqwyhx4x3j0i3ofx` FOREIGN KEY (`repairman_id_2`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FK6wycx2mbko8l7thif2cvjbbhk` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`),
  ADD CONSTRAINT `FK7j1mjubdxsbp76l8pskuj0rap` FOREIGN KEY (`master_preventive_setup_item_id`) REFERENCES `tb_master_preventive_setup_item` (`id`),
  ADD CONSTRAINT `FKkviuw2g7dl1556dte8bvmhu3d` FOREIGN KEY (`driver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKlow86buba282debnyl79ihdwl` FOREIGN KEY (`repairman_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKm289gn9p7okjfl578ktnrtoq5` FOREIGN KEY (`stake_holder_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKmbfrbjvpip6jqov459873ipwh` FOREIGN KEY (`driver_id_2`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKqmohqw5800ybyp1t1r3ku0vey` FOREIGN KEY (`yard_id`) REFERENCES `tb_user_yard` (`id`),
  ADD CONSTRAINT `FKu1o96jbd6n29d6950uka12u1` FOREIGN KEY (`truck_profile_id`) REFERENCES `tb_truck_profile` (`Id`);

--
-- Constraints for table `tb_maintenance_invoice`
--
ALTER TABLE `tb_maintenance_invoice`
  ADD CONSTRAINT `FKgdmnqxx4d2e1vpqinylp7yg3b` FOREIGN KEY (`maintenance_id`) REFERENCES `tb_maintenance` (`id`),
  ADD CONSTRAINT `FKpygh0bjeug9se3866fvsmj1qj` FOREIGN KEY (`supplier_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`);

--
-- Constraints for table `tb_maintenance_preventive`
--
ALTER TABLE `tb_maintenance_preventive`
  ADD CONSTRAINT `FK5s2yjdaobp2v82gnincxqxjk8` FOREIGN KEY (`preventive_setup_detail_id`) REFERENCES `tb_master_preventive_setup_detail` (`id`),
  ADD CONSTRAINT `FKcs2y5vgp6vtc94ledrf1xl4nm` FOREIGN KEY (`preventive_checklist_id`) REFERENCES `tb_master_preventive_checklist` (`id`),
  ADD CONSTRAINT `FKffcg12haql97eeegtw4mxjgmv` FOREIGN KEY (`ma_id`) REFERENCES `tb_maintenance` (`id`);

--
-- Constraints for table `tb_maintenance_service_cost`
--
ALTER TABLE `tb_maintenance_service_cost`
  ADD CONSTRAINT `FK1dfcql7y3cskcp3j1nfig83iy` FOREIGN KEY (`ma_service_type_id`) REFERENCES `tb_master_maintenance_service_cost_type` (`id`),
  ADD CONSTRAINT `FKb9tjnbv03chilqm5j5rux9y69` FOREIGN KEY (`ma_id`) REFERENCES `tb_maintenance` (`id`),
  ADD CONSTRAINT `FKrryxx2tmr0cg9r3ggh7otbhvk` FOREIGN KEY (`ma_spare_part_id`) REFERENCES `tb_maintenance_spare_part` (`id`);

--
-- Constraints for table `tb_maintenance_spare_part`
--
ALTER TABLE `tb_maintenance_spare_part`
  ADD CONSTRAINT `FK9g5kcdj720sddlsd2rw16dhn1` FOREIGN KEY (`spare_parts_stock_id`) REFERENCES `tb_spare_parts_stock` (`id`),
  ADD CONSTRAINT `FKb4aq8fi195see85ew1tacp5gt` FOREIGN KEY (`maintenance_id`) REFERENCES `tb_maintenance` (`id`);

--
-- Constraints for table `tb_maintenance_tire`
--
ALTER TABLE `tb_maintenance_tire`
  ADD CONSTRAINT `FKgsgwuww6639546t8vg7dj14wk` FOREIGN KEY (`pre_history_tire_id`) REFERENCES `tb_history_tire` (`id`),
  ADD CONSTRAINT `FKnwi844o7dewafo6ci6fhxkoyy` FOREIGN KEY (`maintenance_id`) REFERENCES `tb_maintenance` (`id`),
  ADD CONSTRAINT `FKnykui33wy3m9h7exxwdxn3edy` FOREIGN KEY (`spare_parts_stock_id`) REFERENCES `tb_spare_parts_stock` (`id`);

--
-- Constraints for table `tb_master_preventive_checklist`
--
ALTER TABLE `tb_master_preventive_checklist`
  ADD CONSTRAINT `FK39xjqymumyb3yck0av4160uww` FOREIGN KEY (`preventive_mainsystem_id`) REFERENCES `tb_master_preventive_mainsystem` (`id`);

--
-- Constraints for table `tb_master_preventive_setup_detail`
--
ALTER TABLE `tb_master_preventive_setup_detail`
  ADD CONSTRAINT `FKmmu95gdy36x2n455o9169rbbo` FOREIGN KEY (`preventive_checklist_id`) REFERENCES `tb_master_preventive_checklist` (`id`),
  ADD CONSTRAINT `FKonhu58ac4pwwfehngto85mrm5` FOREIGN KEY (`preventive_setup_item_id`) REFERENCES `tb_master_preventive_setup_item` (`id`);

--
-- Constraints for table `tb_master_preventive_setup_item`
--
ALTER TABLE `tb_master_preventive_setup_item`
  ADD CONSTRAINT `FKbb63ew72cr3rm16awqltdpxm0` FOREIGN KEY (`preventive_setup_id`) REFERENCES `tb_master_preventive_setup` (`id`);

--
-- Constraints for table `tb_move_stock`
--
ALTER TABLE `tb_move_stock`
  ADD CONSTRAINT `FK1w90fy9ywno4rnipq3jmuity5` FOREIGN KEY (`des_sps_id`) REFERENCES `tb_spare_parts_stock` (`id`),
  ADD CONSTRAINT `FKrd68wr1dmpe6wagnkqipccb7q` FOREIGN KEY (`dep_sps_id`) REFERENCES `tb_spare_parts_stock` (`id`);

--
-- Constraints for table `tb_move_stock_pdf`
--
ALTER TABLE `tb_move_stock_pdf`
  ADD CONSTRAINT `FK8474luc7yobd41qcoquel73q0` FOREIGN KEY (`yard_org_id`) REFERENCES `tb_user_yard` (`id`),
  ADD CONSTRAINT `FK8oj981nlnsop66gnxvlrw8xht` FOREIGN KEY (`yard_dtn_id`) REFERENCES `tb_user_yard` (`id`);

--
-- Constraints for table `tb_permission`
--
ALTER TABLE `tb_permission`
  ADD CONSTRAINT `tb_permission_ibfk_1` FOREIGN KEY (`id_roles`) REFERENCES `tb_roles` (`roleId`),
  ADD CONSTRAINT `tb_permission_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `tb_menu` (`menu_id`);

--
-- Constraints for table `tb_petty_cash_cost`
--
ALTER TABLE `tb_petty_cash_cost`
  ADD CONSTRAINT `FK47i6cdr5x7fqjomau6iuerxrd` FOREIGN KEY (`accounting_id`) REFERENCES `tb_advance_payment_master` (`advance_payment_id`),
  ADD CONSTRAINT `FK7ugum3nkdq5cehfomsb57oa70` FOREIGN KEY (`expense_detail_id`) REFERENCES `tb_expense_detail` (`id`),
  ADD CONSTRAINT `FK87m454a0t39mvg53pq4qb06pd` FOREIGN KEY (`driver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKacled0h7m3j5pxgh4xuhy9rbc` FOREIGN KEY (`truck_tractor_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKi25uh7hofdk6wc0wfet17u1n6` FOREIGN KEY (`expense_id`) REFERENCES `tb_expense_master` (`id`);

--
-- Constraints for table `tb_petty_cash_master`
--
ALTER TABLE `tb_petty_cash_master`
  ADD CONSTRAINT `FK2k7mla8o544q4v6wwtscte310` FOREIGN KEY (`payer_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FK2nj09f0gx0ky5rpfh58mpr0r4` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`),
  ADD CONSTRAINT `FK60gwnqarh4t7xrstlskt80cpd` FOREIGN KEY (`driver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKsl5atpvbkp4w4gk406vb0ypkb` FOREIGN KEY (`accounting_id`) REFERENCES `tb_advance_payment_master` (`advance_payment_id`);

--
-- Constraints for table `tb_preventive`
--
ALTER TABLE `tb_preventive`
  ADD CONSTRAINT `FK5ml8orv6q1ocnf2sdlq61yslf` FOREIGN KEY (`master_preventive_setup_item_id`) REFERENCES `tb_master_preventive_setup_item` (`id`),
  ADD CONSTRAINT `FK99p1vl0vlrierimxq622kmaof` FOREIGN KEY (`truck_profile_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKgyc7ektpv8b36uae96w135ui2` FOREIGN KEY (`driver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKslgg2u3jo1l371tr6pkd9ytf8` FOREIGN KEY (`yard_id`) REFERENCES `tb_user_yard` (`id`);

--
-- Constraints for table `tb_preventive_item`
--
ALTER TABLE `tb_preventive_item`
  ADD CONSTRAINT `FK6b910tydqck3oobquprws3ko4` FOREIGN KEY (`preventive_code`) REFERENCES `tb_preventive` (`code`);

--
-- Constraints for table `tb_preventive_spare_part`
--
ALTER TABLE `tb_preventive_spare_part`
  ADD CONSTRAINT `FK6m5fpcfusjfjf6inc0ljmdhri` FOREIGN KEY (`preventive_code`) REFERENCES `tb_preventive` (`code`),
  ADD CONSTRAINT `FKadqr75b4pt6yxj0ethcefaeu9` FOREIGN KEY (`spare_parts_stock_id`) REFERENCES `tb_spare_parts_stock` (`id`),
  ADD CONSTRAINT `FKrxu7168aetxbofontwwnf25gn` FOREIGN KEY (`ma_service_type_id`) REFERENCES `tb_master_maintenance_service_cost_type` (`id`);

--
-- Constraints for table `tb_price_edit_history`
--
ALTER TABLE `tb_price_edit_history`
  ADD CONSTRAINT `tb_price_edit_history_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `tb_purchase_order` (`id`),
  ADD CONSTRAINT `tb_price_edit_history_ibfk_2` FOREIGN KEY (`purchase_order_item_id`) REFERENCES `tb_purchase_order_item` (`id`),
  ADD CONSTRAINT `tb_price_edit_history_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `tb_user` (`Id`);

--
-- Constraints for table `tb_purchase_order`
--
ALTER TABLE `tb_purchase_order`
  ADD CONSTRAINT `FK22wtffb92wtv8tvyp09078gj4` FOREIGN KEY (`vendor_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FK4aawm32xmv0k9anw3so0e6r1m` FOREIGN KEY (`pr_id`) REFERENCES `tb_purchase_requisition` (`id`),
  ADD CONSTRAINT `FK9l15tne6qysiqi0g589y9lavf` FOREIGN KEY (`approver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKbmr1n8kc3kqvvni9k69fbbokc` FOREIGN KEY (`requester_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKl36bh8n1kntehy2g9j6ksoljf` FOREIGN KEY (`checker_id`) REFERENCES `tb_user` (`Id`);

--
-- Constraints for table `tb_purchase_order_item`
--
ALTER TABLE `tb_purchase_order_item`
  ADD CONSTRAINT `FK77sccxiggq5jq68bo1of9gbrf` FOREIGN KEY (`pr_item_id`) REFERENCES `tb_purchase_requisition_item` (`id`),
  ADD CONSTRAINT `FKiyb82gj4jt0fb1e276nhvvyto` FOREIGN KEY (`sps_id`) REFERENCES `tb_spare_parts_stock` (`id`),
  ADD CONSTRAINT `tb_purchase_order_item_ibfk_1` FOREIGN KEY (`po_id`) REFERENCES `tb_purchase_order` (`id`);

--
-- Constraints for table `tb_purchase_requisition`
--
ALTER TABLE `tb_purchase_requisition`
  ADD CONSTRAINT `FK2ei9vc9sqkn1y6b7lh1wl0hn5` FOREIGN KEY (`yard_id`) REFERENCES `tb_user_yard` (`id`),
  ADD CONSTRAINT `FK4kt8ypybchskcmnrqwigvns7a` FOREIGN KEY (`department_id`) REFERENCES `tb_user_department` (`id`),
  ADD CONSTRAINT `FK8hedun46pqjijtmxyocce9ii8` FOREIGN KEY (`approver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKi6dmbaiqkf5p7c529javx73qo` FOREIGN KEY (`requester_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKngnqykbh5m5racj2vhwm6qptq` FOREIGN KEY (`checker_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKtj6so9v20iay85xh3d041w26l` FOREIGN KEY (`vendor_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`);

--
-- Constraints for table `tb_purchase_requisition_item`
--
ALTER TABLE `tb_purchase_requisition_item`
  ADD CONSTRAINT `FK9t3ee7vy799j3cer5me4xvnn1` FOREIGN KEY (`yard_id`) REFERENCES `tb_user_yard` (`id`),
  ADD CONSTRAINT `FKrmyyo82x39rb29ww3npderksa` FOREIGN KEY (`sps_id`) REFERENCES `tb_spare_parts_stock` (`id`),
  ADD CONSTRAINT `tb_purchase_requisition_item_ibfk_1` FOREIGN KEY (`pr_id`) REFERENCES `tb_purchase_requisition` (`id`);

--
-- Constraints for table `tb_purchase_return`
--
ALTER TABLE `tb_purchase_return`
  ADD CONSTRAINT `FK2ojj823w7y295ljyqgbhcbpo6` FOREIGN KEY (`vendor_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FK77k7ap5w3bvirjyklu17ni7hw` FOREIGN KEY (`yard_id`) REFERENCES `tb_user_yard` (`id`),
  ADD CONSTRAINT `FKb8hfv25hiqcdto5y25s28yons` FOREIGN KEY (`return_requester_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKfeu866w57792afh87md53005q` FOREIGN KEY (`department_id`) REFERENCES `tb_user_department` (`id`),
  ADD CONSTRAINT `FKk2m58aji2qhgjxe0gny3t214v` FOREIGN KEY (`approver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKpa335jgle8b12hsn5qr153rpq` FOREIGN KEY (`checker_id`) REFERENCES `tb_user` (`Id`);

--
-- Constraints for table `tb_purchase_return_item`
--
ALTER TABLE `tb_purchase_return_item`
  ADD CONSTRAINT `FK9nof6bwkdmqin2e5hojw5cye6` FOREIGN KEY (`spare_parts_stock_id`) REFERENCES `tb_spare_parts_stock` (`id`),
  ADD CONSTRAINT `FKnc4jyhvwmaq73hixgobvjbtsy` FOREIGN KEY (`spare_parts_stock_detail_id`) REFERENCES `tb_spare_parts_stock_detail` (`id`),
  ADD CONSTRAINT `tb_purchase_return_item_ibfk_1` FOREIGN KEY (`prn_id`) REFERENCES `tb_purchase_return` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tb_quotation`
--
ALTER TABLE `tb_quotation`
  ADD CONSTRAINT `FKeqpinpautpyk4prfv87xigvhh` FOREIGN KEY (`customer_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKiev00ji1y7ea2e55iduh05uux` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`Id`);

--
-- Constraints for table `tb_quotation_item`
--
ALTER TABLE `tb_quotation_item`
  ADD CONSTRAINT `FK535tymbp5p9ss2sshboskj33m` FOREIGN KEY (`quotation_id`) REFERENCES `tb_quotation` (`id`),
  ADD CONSTRAINT `FKm7apxjfs190mtjk0wtgdq9nbs` FOREIGN KEY (`truck_type_id`) REFERENCES `tb_truck_type` (`TYPE_ID`),
  ADD CONSTRAINT `FKrxmbrx9cuq0hmm8ad21kdfr7x` FOREIGN KEY (`route_id`) REFERENCES `tb_route_master` (`id`);

--
-- Constraints for table `tb_quotation_rate`
--
ALTER TABLE `tb_quotation_rate`
  ADD CONSTRAINT `FKi84sek6awmuur16hes2684ymo` FOREIGN KEY (`quotation_item_id`) REFERENCES `tb_quotation_item` (`id`);

--
-- Constraints for table `tb_receipt_item_ia`
--
ALTER TABLE `tb_receipt_item_ia`
  ADD CONSTRAINT `FKn5ee91lqcho0inor55ubt3uwk` FOREIGN KEY (`receipt_id`) REFERENCES `tb_receipt_master` (`receipt_no`);

--
-- Constraints for table `tb_receipt_master`
--
ALTER TABLE `tb_receipt_master`
  ADD CONSTRAINT `FK6lxtore1x0p9yqker0a9d9dag` FOREIGN KEY (`customer_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKqp26o2a1j808q7twugxtei58m` FOREIGN KEY (`job_type_id`) REFERENCES `tb_job_type` (`id`),
  ADD CONSTRAINT `FKs84t1qh64o8cf7yvttmwn7bsx` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`);

--
-- Constraints for table `tb_receipt_ra_master`
--
ALTER TABLE `tb_receipt_ra_master`
  ADD CONSTRAINT `FKcqg7idypbnir2xm0qb82efg2u` FOREIGN KEY (`job_type_id`) REFERENCES `tb_job_type` (`id`),
  ADD CONSTRAINT `FKec4cfbp3aebl9bq4d4wr69qpn` FOREIGN KEY (`customer_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKp7r61jwwg0ntflvukrw2fpuik` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`);

--
-- Constraints for table `tb_route_detail`
--
ALTER TABLE `tb_route_detail`
  ADD CONSTRAINT `FKl290vm3vkl9p5ckh4joi7k37u` FOREIGN KEY (`route_id`) REFERENCES `tb_route_master` (`id`),
  ADD CONSTRAINT `FKri6tvmeemotuoi9hw8oo603qa` FOREIGN KEY (`gsdb_id`) REFERENCES `tb_gsdb_code` (`Id`);

--
-- Constraints for table `tb_route_master`
--
ALTER TABLE `tb_route_master`
  ADD CONSTRAINT `FKbra0jqa1heg9jstu7oyipj5g5` FOREIGN KEY (`project_id`) REFERENCES `tb_project` (`PROJECT_ID`),
  ADD CONSTRAINT `FKkjyvi5hic1bogxf9q289rg176` FOREIGN KEY (`customer_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKq2u1h2v4lbqancsagwa7773kb` FOREIGN KEY (`job_type_id`) REFERENCES `tb_job_type` (`id`);

--
-- Constraints for table `tb_route_truck_cost`
--
ALTER TABLE `tb_route_truck_cost`
  ADD CONSTRAINT `FKmwgypu7gwiyqns9iww6ftrith` FOREIGN KEY (`truck_cost_detail_id`) REFERENCES `tb_truck_cost_detail` (`id`),
  ADD CONSTRAINT `FKql5fgv90stjbivprhr4y9ul89` FOREIGN KEY (`truck_cost_id`) REFERENCES `tb_truck_cost_master` (`id`);

--
-- Constraints for table `tb_route_truck_type`
--
ALTER TABLE `tb_route_truck_type`
  ADD CONSTRAINT `FK96qhjyfnhd320yjkt80w9wbua` FOREIGN KEY (`truck_type_id`) REFERENCES `tb_truck_type` (`TYPE_ID`);

--
-- Constraints for table `tb_safety`
--
ALTER TABLE `tb_safety`
  ADD CONSTRAINT `FK698qdevahgym3gt5jqihdjynf` FOREIGN KEY (`truck_profile_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FK91x1hooela6pqqnq240qln01n` FOREIGN KEY (`accident_area_type_id`) REFERENCES `tb_accident_area_type` (`id`),
  ADD CONSTRAINT `FKdebycb9665hfh7r7x4x7cyff8` FOREIGN KEY (`product_ins_company_id`) REFERENCES `tb_insurance_company` (`id`),
  ADD CONSTRAINT `FKdtkkse4t3fg2cdmo5cl8sto43` FOREIGN KEY (`manager_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKe5cqraipdias6yd5qbneto39` FOREIGN KEY (`ma_id`) REFERENCES `tb_maintenance` (`id`),
  ADD CONSTRAINT `FKe6kblaavb3rqfr4t379rfkrwn` FOREIGN KEY (`product_ins_broker_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKeq0065omspbd8w4apl4n9rj1n` FOREIGN KEY (`accident_type_id`) REFERENCES `tb_accident_type` (`id`),
  ADD CONSTRAINT `FKljc7vxx5a9g5484sbt10m028y` FOREIGN KEY (`job_id`) REFERENCES `tb_job_master` (`job_id`),
  ADD CONSTRAINT `FKlqpqwnrsokck80r98lnucrr5s` FOREIGN KEY (`car_ins_broker_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKr7nto7ga0ggq79mq3fqa0o1go` FOREIGN KEY (`driver_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKsej5k0ccqmb0n79wlpa04wu8i` FOREIGN KEY (`car_ins_company_id`) REFERENCES `tb_insurance_company` (`id`),
  ADD CONSTRAINT `FKsrla6gqiro45pi0bsa8yuqprf` FOREIGN KEY (`fault_acident_type_id`) REFERENCES `tb_fault_accident_type` (`id`);

--
-- Constraints for table `tb_safety_attachment`
--
ALTER TABLE `tb_safety_attachment`
  ADD CONSTRAINT `FK4xlv6beqnd3sa2cflkgtpi3dg` FOREIGN KEY (`safety_id`) REFERENCES `tb_safety` (`id`),
  ADD CONSTRAINT `FK8fvay7u5gptskduxamp13b16a` FOREIGN KEY (`safety_attachment_type_id`) REFERENCES `tb_safety_attachment_type` (`id`);

--
-- Constraints for table `tb_spare_parts`
--
ALTER TABLE `tb_spare_parts`
  ADD CONSTRAINT `FK1p2uqoqw3tvhu68cy3dtt40se` FOREIGN KEY (`spare_parts_type_id`) REFERENCES `tb_spare_parts_type` (`id`);

--
-- Constraints for table `tb_spare_parts_stock`
--
ALTER TABLE `tb_spare_parts_stock`
  ADD CONSTRAINT `FKbdnhotac78nosf5gogwc2u2s6` FOREIGN KEY (`yard_id`) REFERENCES `tb_user_yard` (`id`),
  ADD CONSTRAINT `FKc0dun98k0suc5mlqrwg24ehh9` FOREIGN KEY (`spare_parts_type_id`) REFERENCES `tb_spare_parts_type` (`id`),
  ADD CONSTRAINT `FKhlquh0iade2v48r0p4i1ux6lu` FOREIGN KEY (`spare_parts_id`) REFERENCES `tb_spare_parts` (`id`),
  ADD CONSTRAINT `FKri4gwlxx5v9cmyg0qm667nf69` FOREIGN KEY (`master_spare_part_unit_id`) REFERENCES `tb_master_spare_part_unit` (`id`);

--
-- Constraints for table `tb_spare_parts_stock_detail`
--
ALTER TABLE `tb_spare_parts_stock_detail`
  ADD CONSTRAINT `FK2v0m8n5os9ru2t06ct655icpe` FOREIGN KEY (`spare_parts_stock_id`) REFERENCES `tb_spare_parts_stock` (`id`),
  ADD CONSTRAINT `FKti4hm49kkqy2kkt4m2p7esrmh` FOREIGN KEY (`move_stock_id`) REFERENCES `tb_move_stock` (`id`);

--
-- Constraints for table `tb_sr_master`
--
ALTER TABLE `tb_sr_master`
  ADD CONSTRAINT `FKdvf43oam1ep751wlbemadxtr9` FOREIGN KEY (`customer_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`);

--
-- Constraints for table `tb_stake_holder_attachment`
--
ALTER TABLE `tb_stake_holder_attachment`
  ADD CONSTRAINT `FKsdqf7h533s8m1mkfu9k4o0d0c` FOREIGN KEY (`stake_holder_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`);

--
-- Constraints for table `tb_stake_holder_master`
--
ALTER TABLE `tb_stake_holder_master`
  ADD CONSTRAINT `FK227cx8vewsgyp84u3lxkeyp40` FOREIGN KEY (`STAKE_HOLDER_PROJECT`) REFERENCES `tb_project` (`PROJECT_ID`),
  ADD CONSTRAINT `FK5jxrbxyx1og3yfwihcw6f23ap` FOREIGN KEY (`STAKE_HOLDER_PAYMENT_METHOD`) REFERENCES `tb_payment_method` (`PAYMENT_METHOD_ID`),
  ADD CONSTRAINT `FKcmnndxbtv9d5y600sxv6emmwa` FOREIGN KEY (`STAKE_HOLDER_PAYMENT_METHOD`) REFERENCES `tb_payment_method` (`PAYMENT_METHOD_ID`),
  ADD CONSTRAINT `FKdj09nxpre9awdpn9infoqy29r` FOREIGN KEY (`STAKE_HOLDER_SALE_TYPE`) REFERENCES `tb_sale_type` (`SALE_TYPE_ID`),
  ADD CONSTRAINT `FKe0k47440e25qdstbk65xwj98` FOREIGN KEY (`customer_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKh7kx8ts0uqsrb3k8e8fixjmo3` FOREIGN KEY (`STAKE_HOLDER_CREDIT_TERM`) REFERENCES `tb_credit_term` (`CREDIT_TERM_ID`),
  ADD CONSTRAINT `FKis445ie62wl5by3ekm5fcu1d3` FOREIGN KEY (`STAKE_HOLDER_CREDIT_TERM`) REFERENCES `tb_credit_term` (`CREDIT_TERM_ID`),
  ADD CONSTRAINT `FKks699q85mhwqvsgwo7bogghaf` FOREIGN KEY (`STAKE_HOLDER_PROVINCE_ID`) REFERENCES `tb_province` (`id`),
  ADD CONSTRAINT `FKqrrsjm8yga9jsx06g9i07b73s` FOREIGN KEY (`STAKE_HOLDER_SALE_TYPE`) REFERENCES `tb_sale_type` (`SALE_TYPE_ID`),
  ADD CONSTRAINT `FKs2nrfmg08uvow9ph7y4ru38rn` FOREIGN KEY (`STAKE_HOLDER_PROVINCE_ID`) REFERENCES `tb_province` (`id`),
  ADD CONSTRAINT `FKtollk6of3k9irgfhfimko0goa` FOREIGN KEY (`STAKE_HOLDER_PROJECT`) REFERENCES `tb_project` (`PROJECT_ID`);

--
-- Constraints for table `tb_tire_history`
--
ALTER TABLE `tb_tire_history`
  ADD CONSTRAINT `FK33jkovtdgyn6qt47ya101witm` FOREIGN KEY (`new_parent_id`) REFERENCES `tb_spare_parts_stock` (`id`),
  ADD CONSTRAINT `FK5ievch93pc65q8ktpymnw2au3` FOREIGN KEY (`tire_id`) REFERENCES `tb_spare_parts_stock` (`id`),
  ADD CONSTRAINT `FKpxnubncb4pykrgvds8ekuoxtv` FOREIGN KEY (`old_parent_id`) REFERENCES `tb_spare_parts_stock` (`id`);

--
-- Constraints for table `tb_tire_return_stock`
--
ALTER TABLE `tb_tire_return_stock`
  ADD CONSTRAINT `FKmwkixan29xpb809oxa72s4o5w` FOREIGN KEY (`maintenance_tire_id`) REFERENCES `tb_maintenance_tire` (`id`);

--
-- Constraints for table `tb_truck_profile`
--
ALTER TABLE `tb_truck_profile`
  ADD CONSTRAINT `FK24os4paf285i7cb1n68bwq8a` FOREIGN KEY (`PROJECT_ID`) REFERENCES `tb_project` (`PROJECT_ID`),
  ADD CONSTRAINT `FK36gf3ami05ssfkugr2srmn3c5` FOREIGN KEY (`Yard_Id`) REFERENCES `tb_masteryard` (`Yard_Id`),
  ADD CONSTRAINT `FK9f6lk80sb78udy96r6tdjhbt` FOREIGN KEY (`Yard_Id`) REFERENCES `tb_masteryard` (`Yard_Id`),
  ADD CONSTRAINT `FKgl20purlfsj19nq71233yh31c` FOREIGN KEY (`TRUCK_PROVINCE_ID`) REFERENCES `tb_province` (`id`),
  ADD CONSTRAINT `FKifs9yc0bioda1kfwisvmnk6vh` FOREIGN KEY (`TRUCK_PROVINCE_ID`) REFERENCES `tb_province` (`id`),
  ADD CONSTRAINT `FKjdnncy8c793wvsdsoei6ctiq6` FOREIGN KEY (`COMPANY`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKjmvdxop08i4xv1h4jmy5s71ko` FOREIGN KEY (`PROJECT_ID`) REFERENCES `tb_project` (`PROJECT_ID`),
  ADD CONSTRAINT `FKpr8p6exvl9dqne5tvixvccxyf` FOREIGN KEY (`GPS_TYPE_ID`) REFERENCES `tb_gps_type` (`Id`),
  ADD CONSTRAINT `FKqf73fvnf0tf4e8sq2dlgkspda` FOREIGN KEY (`COMPANY`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FKrs2rxr14hkr32sht9ohhxxd4j` FOREIGN KEY (`GPS_TYPE_ID`) REFERENCES `tb_gps_type` (`Id`);

--
-- Constraints for table `tb_truck_profile_attachment`
--
ALTER TABLE `tb_truck_profile_attachment`
  ADD CONSTRAINT `FK9dbl9d9uysfg6cdbwd8743ft4` FOREIGN KEY (`truck_profile_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKm0b9sedjdfmxqptsod2p3mwjq` FOREIGN KEY (`truck_profile_attachment_type_id`) REFERENCES `tb_truck_profile_attachment_type` (`id`);

--
-- Constraints for table `tb_truck_profile_image`
--
ALTER TABLE `tb_truck_profile_image`
  ADD CONSTRAINT `FK7galse0berfou0usftdcc7fcs` FOREIGN KEY (`truck_profile_id`) REFERENCES `tb_truck_profile` (`Id`),
  ADD CONSTRAINT `FKtm1pkrpl8wf52yteln23t8qgv` FOREIGN KEY (`truck_profile_image_type_id`) REFERENCES `tb_truck_profile_image_type` (`id`);

--
-- Constraints for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD CONSTRAINT `FK1dll2gl2ns2lv5b1rdb2vf2ht` FOREIGN KEY (`idcard_issued_province_id`) REFERENCES `tb_province` (`id`),
  ADD CONSTRAINT `FK3t30scykia7ngamcyf7nxs5vn` FOREIGN KEY (`cust_company_id`) REFERENCES `tb_stake_holder_master` (`STAKE_HOLDER_UN_ID`),
  ADD CONSTRAINT `FK683cwgqdbbg9tqv0w6uuyjwh9` FOREIGN KEY (`nationality_id`) REFERENCES `tb_user_nationality` (`code`),
  ADD CONSTRAINT `FK7fh9iiiuh2a2pg4cxnet5pe42` FOREIGN KEY (`present_addr_province_id`) REFERENCES `tb_province` (`id`),
  ADD CONSTRAINT `FK892ogvj4mdm0reg5xap2983tb` FOREIGN KEY (`status_id`) REFERENCES `tb_user_status` (`id`),
  ADD CONSTRAINT `FKbrxnovvafef2xyc7qw7kj6mk2` FOREIGN KEY (`emp_section_id`) REFERENCES `tb_emp_section` (`id`),
  ADD CONSTRAINT `FKdif88hhuupydh4u0incn9rtvl` FOREIGN KEY (`emp_comp_id`) REFERENCES `tb_emp_company` (`id`),
  ADD CONSTRAINT `FKe5iaii1jr1kkyuvlar75n7n92` FOREIGN KEY (`section_id`) REFERENCES `tb_user_section` (`id`),
  ADD CONSTRAINT `FKe8x5gkmnqrat5inv546q00w8o` FOREIGN KEY (`gender_id`) REFERENCES `tb_user_gender` (`code`),
  ADD CONSTRAINT `FKel0ole1gwx1oxx1o2jfg0tcx9` FOREIGN KEY (`position_id`) REFERENCES `tb_user_position` (`id`),
  ADD CONSTRAINT `FKfcn2599uuym0asvv15ara0ikr` FOREIGN KEY (`emp_position_id`) REFERENCES `tb_emp_position` (`id`),
  ADD CONSTRAINT `FKgkf20gvsqfed6jpvbd9j2t8lv` FOREIGN KEY (`emp_dpm_id`) REFERENCES `tb_emp_department` (`id`),
  ADD CONSTRAINT `FKhi0v5imh3jb2wh8j5j8q3ndvy` FOREIGN KEY (`title_id`) REFERENCES `tb_user_title` (`id`),
  ADD CONSTRAINT `FKjivp2ksdjydsxv0ocgg4pfskp` FOREIGN KEY (`emp_type_id`) REFERENCES `tb_emp_type` (`id`),
  ADD CONSTRAINT `FKlesqlrptevam99hb7287ralg6` FOREIGN KEY (`type_id`) REFERENCES `tb_user_type` (`id`),
  ADD CONSTRAINT `FKmdny98dr1543qqtmqpn71y0s9` FOREIGN KEY (`religion_id`) REFERENCES `tb_user_religion` (`code`),
  ADD CONSTRAINT `FKn4pia86jdp765e8xccw2e7n5s` FOREIGN KEY (`yard_id`) REFERENCES `tb_user_yard` (`id`),
  ADD CONSTRAINT `FKnpwd46j21x9atrsx9onxwdrw3` FOREIGN KEY (`present_addr_bank_id`) REFERENCES `tb_bank` (`code`),
  ADD CONSTRAINT `FKo0iqymuvbpk88ghcs7syg3vax` FOREIGN KEY (`department_id`) REFERENCES `tb_user_department` (`id`),
  ADD CONSTRAINT `FKqphgwitgf4n7a0w8v488nnlts` FOREIGN KEY (`company_id`) REFERENCES `tb_user_company` (`id`),
  ADD CONSTRAINT `FKs6efvsl2ssefeu6w3j4e9u24v` FOREIGN KEY (`idcard_addr_province_id`) REFERENCES `tb_province` (`id`),
  ADD CONSTRAINT `FKsx06yyxoaecbnl7dr02jbmfsx` FOREIGN KEY (`education_id`) REFERENCES `tb_education` (`code`),
  ADD CONSTRAINT `FKt4713a85a0v9gp3qyjcw4oeh2` FOREIGN KEY (`race_id`) REFERENCES `tb_user_nationality` (`code`);

--
-- Constraints for table `tb_users_roles`
--
ALTER TABLE `tb_users_roles`
  ADD CONSTRAINT `FK85qorv8qojsxvl1nv56vckxmj` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`Id`),
  ADD CONSTRAINT `FKariud4fp9diekkpe7upfn77mq` FOREIGN KEY (`role_id`) REFERENCES `tb_user_role` (`id`);

--
-- Constraints for table `tb_user_attachment`
--
ALTER TABLE `tb_user_attachment`
  ADD CONSTRAINT `FK14w1wsodhcbpotffmthjvrca6` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`Id`);

--
-- Constraints for table `tb_user_image`
--
ALTER TABLE `tb_user_image`
  ADD CONSTRAINT `FKpjsp39m1pa1vn3p2qryw4ak90` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
