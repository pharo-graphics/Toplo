"
A ToTooltipWindowTest is a test class for testing the behavior of ToTooltipWindow
"
Class {
	#name : #ToTooltipWindowTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Tooltip'
}

{ #category : #tests }
ToTooltipWindowTest >> testEmptyWindow [

	| w |
	w := ToTooltipWindow new.
	self assert: w associateElement isNil	
]
