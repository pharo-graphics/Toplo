Class {
	#name : #ToGeneralButtonTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Widget-Button'
}

{ #category : #tests }
ToGeneralButtonTest >> testGeneralButton [
	"Test default values of a new general button"

	| button |
	button := ToGeneralButton new.
	
	self assert: button isEnabled.
	self assert: button isDisabled equals: false.
	
	self assert: button tooltip isNil.
	self assert: button tooltipContent isNil.
	
]

{ #category : #tests }
ToGeneralButtonTest >> testGeneralButtonTooltip [
	"Test default values of a new general button"

	| button |
	button := ToGeneralButton new.
	button tooltipContent: 'I am a tooltip content'.	
	
	self assert: button tooltip notNil.
	self assert: button tooltipContent equals: 'I am a tooltip content'.
]
