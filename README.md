localvhost
===========

Agnostic Virtual Host Management for Local Environments.

Built within the ever-iterating Shells on the Beach shell script framework.

Forks wwwoosh (https://github.com/tlrobinson/wwwoosh) as an experimental extension.

Shells on the Beach Structure
===

```
APP  
|  
|--config  
|   |--APP_NAME.conf (end/user configuration)  
|	+--APP_NAME.conf.tpl (end/user configuration template)  
|  
|--data  
|	+--? (app specific data)  
|  
|--inc  
|	|--controllers  
|	|	+--? (app specific controller scripts)  
|	|  
|	|--static  
|	|	+--? (app specific static content)  
|	|  
|	|--extensions  
|	|	+--? (scripts that extend core app functionality)  
|	|  
|	|--app.routes (routing information for app)  
|	|--functions.sh (core app functions)  
|	|--log.sh (core logging functions)  
|	|--preprocess.sh (preprocess script -- executed prior to routing)  
|	+--process.sh (process script -- executes routing and post-routing)  
|  
|--log  
|	+--APP_NAME.log (app log)  
|  
+--sbin  
	+--app.sh (app execution script)  
```
