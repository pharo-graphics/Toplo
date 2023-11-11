"
A ToStyleStampTest is a test class for testing the behavior of ToStyleStamp
"
Class {
	#name : #ToStyleStampTest,
	#superclass : #TestCase,
	#category : 'Toplo-Tests-Core-Properties'
}

{ #category : #tests }
ToStyleStampTest >> testAsStyleStamp [

	| s |
	s := #color asStyleStamp.
	self assert: s name identicalTo: #color.
	self assert: s value.
	
	s := 'color' asStyleStamp.
	self assert: s name identicalTo: #color.
	self assert: s value.
	
	s := ('color' -> Color red) asStyleStamp.
	self assert: s name identicalTo: #color.
	self assert: s value identicalTo: Color red.
	
	self should: [Object new asStyleStamp] raise: Error
	

]

{ #category : #tests }
ToStyleStampTest >> testName [

	| s |
	s := ToStyleStamp new.
	self assert: s name isNil.
	
	s name: #color.
	self assert: s name identicalTo: #color.
	s name: 'color'.
	self assert: s name identicalTo: #color.
	self should: [s name: Object new] raise: Error.
	
	s := ToStyleStamp name: #background value: (BlBackground paint: Color white).
	self assert: s name equals: #background.
	self assert: s value paint color equals: Color white

]

{ #category : #tests }
ToStyleStampTest >> testRead [

	| s |
	s := ToStyleStamp new.

	s name: #color.
	s value: [ :e | Color red ].
	self assert: s value isClosure.
	self assert: (s read: nil) identicalTo: Color red.

]

{ #category : #tests }
ToStyleStampTest >> testValue [

	| s |
	s := ToStyleStamp new.
	self assert: s value isNil.
	
	s name: #color.
	s value: Color red.
	
	self assert: s value identicalTo: Color red

]
