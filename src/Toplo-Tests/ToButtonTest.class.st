Class {
	#name : #ToButtonTest,
	#superclass : #ToTestCase,
	#category : #'Toplo-Tests-Widget'
}

{ #category : #tests }
ToButtonTest >> testButton [
	"Test default values of a new button"

	| button |
	button := ToButton new.
	
	self assert: button isHorizontal. 
	self assert: button isLeftToRight.
	self assert: button isRightToLeft equals: false.
	
	self assert: button isIconFirst.
	self assert: button isLabelFirst equals: false.
	
	self assert: button icon notNil.
	self assert: button iconImage isNil.
	
	self assert: button label notNil.
	self assert: button labelText isNil.
]

{ #category : #tests }
ToButtonTest >> testButtonDefaultDresser [
	
	| button |
	button := ToButton new.
	
	self assert: button defaultDresser class equals: ToButtonDresser.
]

{ #category : #tests }
ToButtonTest >> testButtonDresser [
	
	| button |
	button := ToButton new.
	
	self assert: button dresser class equals: ToButtonDresser.
]
