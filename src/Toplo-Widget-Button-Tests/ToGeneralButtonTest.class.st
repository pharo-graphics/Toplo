Class {
	#name : 'ToGeneralButtonTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Widget-Button-Tests-Core',
	#package : 'Toplo-Widget-Button-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
ToGeneralButtonTest >> testGeneralButton [
	"Test default values of a new general button"

	| button |
	button := ToGeneralButton new.

	self assert: button isEnabled.
	self assert: button isDisabled equals: false.

	self assert: button currentTooltipWindow isNil.
	self assert: button tooltip isNil
]

{ #category : 'tests' }
ToGeneralButtonTest >> testGeneralButtonTooltip [
	"Test default values of a new general button"

	| button |
	button := ToGeneralButton new.
	button tooltipText: 'I am a tooltip content'.

	self assert: button currentTooltipWindow isNil.
	self assert: button tooltip text asString equals: 'I am a tooltip content'
]
