"
A TToEnableableTest is a test class for testing the behavior of TToEnableable
"
Class {
	#name : #TToEnableableTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
TToEnableableTest >> testDisabled [

	| element |
	element := ToElement new.
	element disabled: true. 
	self assert: element isDisabled.	
	self assert: element isEnabled not.
	element disabled: false. 
	self assert: element isEnabled.
	self assert: element isDisabled not.	

]

{ #category : #tests }
TToEnableableTest >> testEnableable [

	| element |
	element := ToElement new.
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

{ #category : #tests }
TToEnableableTest >> testEnabled [

	| element |
	element := ToElement new.
	element enabled: true. 
	self assert: element isEnabled.
	self assert: element isDisabled not.	
	element enabled: false. 
	self assert: element isDisabled.	
	self assert: element isEnabled not.
]

{ #category : #tests }
TToEnableableTest >> testFlagAsDisabled [

	| element child |
	element := ToElement new.
	element flagAsDisabled.
	self deny: (element  toploExtension enabled).
	self assert: element isDisabled.
	element flagAsEnabled.
	self assert: element  toploExtension enabled.
	child := ToElement new.
	self assert: child isEnabled.

]

{ #category : #tests }
TToEnableableTest >> testMultipleDisable [

	| element |
	element := ToElement new.
	element disable. 
	element disable. 
	element disable. 
	self assert: element isDisabled.
]

{ #category : #tests }
TToEnableableTest >> testOnAddedToParent [

	| parent child |
	parent := ToElement new.
	child := ToElement new.
	parent enabled: false.
	self assert: child isEnabled.
	parent addChild: child.
	self assert: child isDisabled
]

{ #category : #tests }
TToEnableableTest >> testWithChild [

	| parent child |
	parent := ToElement new.
	child := ToElement new.
	parent addChild: child.
	parent disabled: true.
	self assert: parent isDisabled.
	self assert: child isDisabled.
	parent disabled: false.
	self assert: parent isEnabled.
	self assert: child isEnabled
]
