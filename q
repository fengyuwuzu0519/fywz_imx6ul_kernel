[1mdiff --git a/arch/arm/boot/dts/mys-imx6ul-14x14-evk.dts b/arch/arm/boot/dts/mys-imx6ul-14x14-evk.dts[m
[1mindex 303fec8..2ff727d 100644[m
[1m--- a/arch/arm/boot/dts/mys-imx6ul-14x14-evk.dts[m
[1m+++ b/arch/arm/boot/dts/mys-imx6ul-14x14-evk.dts[m
[36m@@ -120,7 +120,7 @@[m
 [m
         led1: user {[m
 			label = "cpu";[m
[31m-			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;[m
[32m+[m			[32mgpios = <&gpio5 8 GPIO_ACTIVE_LOW>;[m
 			default-state = "on";[m
 			linux,default-trigger = "heartbeat";[m
 		};[m
[36m@@ -156,8 +156,8 @@[m
 	pinctrl-0 = <&pinctrl_enet1>;[m
 	phy-mode = "rmii";[m
 	phy-handle = <&ethphy0>;[m
[31m-    phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;[m
[31m-    phy-reset-duration = <5>;[m
[32m+[m[41m    [m	[32mphy-reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;[m
[32m+[m[41m    [m	[32mphy-reset-duration = <5>;[m
 	status = "okay";[m
 [m
     mdio {[m
[36m@@ -370,7 +370,7 @@[m
 [m
 		pinctrl_pwm1: pwm1grp {[m
 			fsl,pins = <[m
[31m-				MX6UL_PAD_GPIO1_IO08__PWM1_OUT   0x110b0[m
[32m+[m				[32m/*MX6UL_PAD_GPIO1_IO09__PWM1_OUT   0x110b0*/[m
 			>;[m
 		};[m
 [m
[1mdiff --git a/arch/arm/configs/mys_imx6_defconfig b/arch/arm/configs/mys_imx6_defconfig[m
[1mindex 8bc832d..3fc92f7 100644[m
[1m--- a/arch/arm/configs/mys_imx6_defconfig[m
[1m+++ b/arch/arm/configs/mys_imx6_defconfig[m
[36m@@ -458,3 +458,4 @@[m [mCONFIG_LIBCRC32C=m[m
 CONFIG_FONTS=y[m
 CONFIG_FONT_8x8=y[m
 CONFIG_FONT_8x16=y[m
[32m+[m[32mCONFIG_OF[m
[1mdiff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c[m
[1mindex 96fd0e9..f40f2a6 100644[m
[1m--- a/drivers/net/ethernet/freescale/fec_main.c[m
[1m+++ b/drivers/net/ethernet/freescale/fec_main.c[m
[36m@@ -3352,7 +3352,8 @@[m [mstatic void fec_reset_phy(struct platform_device *pdev)[m
 [m
 	if (!np)[m
 		return;[m
[31m-[m
[32m+[m[41m	[m
[32m+[m	[32mprintk("yangfei :fec_reset_phy\n");[m
 	err = of_property_read_u32(np, "phy-reset-duration", &fep->phy_reset_msec);[m
 	/* A sane reset duration should not be longer than 1s */[m
 	if (!err && fep->phy_reset_msec > 1000)[m
[1mdiff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c[m
[1mindex 71190dc..7b0a899 100644[m
[1m--- a/drivers/net/usb/qmi_wwan.c[m
[1m+++ b/drivers/net/usb/qmi_wwan.c[m
[36m@@ -846,6 +846,7 @@[m [mstatic const struct usb_device_id products[] = {[m
 	{QMI_GOBI_DEVICE(0x1199, 0x901b)},	/* Sierra Wireless MC7770 */[m
 	{QMI_GOBI_DEVICE(0x12d1, 0x14f1)},	/* Sony Gobi 3000 Composite */[m
 	{QMI_GOBI_DEVICE(0x1410, 0xa021)},	/* Foxconn Gobi 3000 Modem device (Novatel E396) */[m
[32m+[m	[32m{QMI_GOBI_DEVICE(0x1e0e, 0x9001)},	/* Foxconn Gobi 3000 Modem device (Novatel E396) */[m
 [m
 	{ }					/* END */[m
 };[m
[1mdiff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c[m
[1mindex 204cd83..a8a80c7 100644[m
[1m--- a/drivers/usb/serial/option.c[m
[1m+++ b/drivers/usb/serial/option.c[m
[36m@@ -96,6 +96,10 @@[m [mstatic void option_instat_callback(struct urb *urb);[m
 [m
 #define NOVATELWIRELESS_VENDOR_ID		0x1410[m
 [m
[32m+[m[32m#define	SIMCOM_SIM7600_VID	0x1E0E[m
[32m+[m
[32m+[m[32m#define	SIMCOM_SIM7600_PID	0x9001[m
[32m+[m
 /* YISO PRODUCTS */[m
 [m
 #define YISO_VENDOR_ID				0x0EAB[m
[36m@@ -533,6 +537,9 @@[m [mstatic const struct option_blacklist_info alcatel_x200_blacklist = {[m
 	.sendsetup = BIT(0) | BIT(1),[m
 	.reserved = BIT(4),[m
 };[m
[32m+[m[32mstatic const struct option_blacklist_info simcom_sim7600_blacklist = {[m
[32m+[m	[32m.reserved = BIT(5),[m
[32m+[m[32m};[m
 [m
 static const struct option_blacklist_info zte_0037_blacklist = {[m
 	.sendsetup = BIT(0) | BIT(1),[m
[36m@@ -675,6 +682,8 @@[m [mstatic const struct usb_device_id option_ids[] = {[m
 		.driver_info = (kernel_ulong_t) &net_intf1_blacklist },[m
 	{ USB_DEVICE_AND_INTERFACE_INFO(HUAWEI_VENDOR_ID, HUAWEI_PRODUCT_K4605, 0xff, 0xff, 0xff),[m
 		.driver_info = (kernel_ulong_t) &huawei_cdc12_blacklist },[m
[32m+[m	[32m{ USB_DEVICE(SIMCOM_SIM7600_VID, SIMCOM_SIM7600_PID),[m
[32m+[m		[32m.driver_info = (kernel_ulong_t) &simcom_sim7600_blacklist },[m
 	{ USB_VENDOR_AND_INTERFACE_INFO(HUAWEI_VENDOR_ID, 0xff, 0xff, 0xff) },[m
 	{ USB_VENDOR_AND_INTERFACE_INFO(HUAWEI_VENDOR_ID, 0xff, 0x01, 0x01) },[m
 	{ USB_VENDOR_AND_INTERFACE_INFO(HUAWEI_VENDOR_ID, 0xff, 0x01, 0x02) },[m
