Class {
	#name : #ToGeneralButtonTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Button-Tests-Core'
}

{ #category : #tests }
ToGeneralButtonTest >> testGeneralButton [
	"Test default values of a new general button"

	| button |
	button := ToGeneralButton new.

	self assert: button isEnabled.
	self assert: button isDisabled equals: false.

	self assert: button currentTooltipWindow isNil.
	self assert: button tooltipContent isNil
]

{ #category : #tests }
ToGeneralButtonTest >> testGeneralButtonTooltip [
	"Test default values of a new general button"

	| button |
	button := ToGeneralButton new.
	button tooltipText: 'I am a tooltip content'.

	self assert: button currentTooltipWindow isNil.
	self assert: button tooltipContent text asString equals: 'I am a tooltip content'
]
