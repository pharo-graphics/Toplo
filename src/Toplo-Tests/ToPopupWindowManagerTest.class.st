"
A ToPopupWindowManagerTest is a test class for testing the behavior of ToPopupWindowManager
"
Class {
	#name : 'ToPopupWindowManagerTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Window',
	#package : 'Toplo-Tests',
	#tag : 'Core-Window'
}

{ #category : 'running' }
ToPopupWindowManagerTest >> setUp [ 

	super setUp.
	space := self newTestingSpace.

]
