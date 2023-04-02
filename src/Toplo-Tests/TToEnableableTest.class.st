"
A TToEnableableTest is a test class for testing the behavior of TToEnableable
"
Class {
	#name : #TToEnableableTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
TToEnableableTest >> testEnableable [

	| element |
	element := ToWidget new.
	self assert: element isEnabled.
	self assert: element isDisabled not.
	
	element disable.
	self assert: element isEnabled not.
	self assert: element isDisabled.
	
	element enable.
	self assert: element isEnabled.
	self assert: element isDisabled not.
	
	element disabled: true.
	self assert: element isEnabled not.
	self assert: element isDisabled.
	
	element enabled: true.
	self assert: element isEnabled.
	self assert: element isDisabled not.
	
	element enabled: false.
	self assert: element isEnabled not.
	self assert: element isDisabled.
	
	element disabled: false.
	self assert: element isEnabled.
	self assert: element isDisabled not.
]
