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
	self deny: button isDisabled
]

{ #category : #tests }
ToGeneralButtonTest >> testGeneralButtonTooltip [
	"Test default values of a new general button"

	| button |
	button := ToGeneralButton new.
	button tooltipText: 'I am a tooltip content'.
	self assert: button currentTooltipWindow isNil.
	self assert: button rawTooltipManager notNil
]
