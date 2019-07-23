<?php

$phpVersions = (glob('/src/test/php/module_lists/*'));

foreach ($phpVersions as $key => $phpVersion) {
	$phpVersions[$key] = str_replace(['/src/test/php/module_lists/', '.list'], '', $phpVersion);
}


$modules = array();
foreach ($phpVersions as $key => $phpVersion) {
	
	$modules[$phpVersion] = explode("\n", file_get_contents('/src/test/php/module_lists/' . $phpVersion . '.list')); 

	// Filter some lines out
	foreach ($modules[$phpVersion] as $lineKey => $line) {
		if ($line === '[PHP Modules]' || $line === '' || $line === '[Zend Modules]') {
			unset($modules[$phpVersion][$lineKey]);
		}
	}

}

$allModules = array();
foreach ($modules[$phpVersion] as $key => $module) {
	if (!isset($allModules[$module])) {
		$allModules[$module] = array();
	}
}

// Now add modules for each version
foreach ($allModules as $module => $value) {
	
	foreach ($modules as $phpVersion => $moduleList) {
		foreach ($moduleList as $moduleExistsKey => $moduleExists) {
			if ($moduleExists === $module) {
				$allModules[$module][$phpVersion] = TRUE;
			}
		}
	}
}

// Build the output
$output = '';
$output .= '| Module |';

foreach ($phpVersions as $key => $phpVersion) {
	$output .= ' ' . $phpVersion . ' |';
}
$output .= "\n";
$output .= "| --- |";
foreach ($phpVersions as $key => $phpVersion) {
	$output .= ' --- |';
}
$output .= "\n";
foreach ($allModules as $moduleName => $moduleVersions) {
	$output .= '| ' . $moduleName . ' |';
	foreach ($phpVersions as $key => $phpVersion) {
		if ($moduleVersions[$phpVersion] === TRUE) {
			$output .= ' ✓ |';
		}
		else {
			$output .= ' ✖ |';
		}
	}
	$output .= "\n";
}

//print_r($modules);
$readme = file_get_contents('/src/README.md');
$readme = str_replace('{{ MODULES_TABLE }}', $output, $readme);

file_put_contents('/src/README.md', $readme);

?>