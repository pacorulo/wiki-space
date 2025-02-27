If Eclipse is fliking (blinking) in the main window all the time, it is due to https://github.com/eclipse-platform/eclipse.platform.swt/issues/270

It can be resolved in the following way:

1. you can remove ~/.xinputrc and reboot
2. you can set the variable GTK\_IM\_MODULE to ibus instead of default value being: env GTK\_IM\_MODULE=ibus. In order to do it, you can use the command:
```
im-config -n ibus
```
Before executing previous command you can check the current values with `im-config -a` and you will get a small window with a prompt like below:
```
Current configuration for the input method:
 * Default mode defined in /etc/default/im-config: 'auto'
 * Active configuration: 'xim' (normally missing)
 * Normal automatic choice: 'none' (normally ibus or fcitx5)
 * Override rule: 'zh_CN,fcitx5:zh_TW,fcitx5:zh_HK,fcitx5:zh_SG,fcitx5'
 * Current override choice: '' (Locale='en_US')
 * Current automatic choice: 'none'
 * Number of valid choices: 11 (normally 1)
 * Desktop environment: 'MATE'
The configuration set by im-config is activated by re-starting the system.
Explicit selection is not required to enable the automatic configuration if the active one is default/auto/cjkv/missing.
  Available input methods: ibus fcitx fcitx5 uim hime gcin maliit scim thai xim kinput2 xsunpinyin
    Unless you really need them all, please make sure to install only one input method tool.
```
Therefor, you can re-check it after changing the value and rebooting the pc... OR you can execute: `im-config -a` and select YES so a new window will let you modify the value to ibus.

On each case you will get (after rebooting the pc) the new value and Eclipse won't flik any more :)
```
$ env | grep GTK
GTK_IM_MODULE=ibus
```
