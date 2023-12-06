Class {
	#name : 'ToElementForStyleRuleTest',
	#superclass : 'ToElement',
	#instVars : [
		'themeForSetup'
	],
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 'initialization' }
ToElementForStyleRuleTest >> setUpByTheme: aTheme [

	themeForSetup := aTheme
]

{ #category : 'accessing' }
ToElementForStyleRuleTest >> themeForSetup [

	^ themeForSetup
]
