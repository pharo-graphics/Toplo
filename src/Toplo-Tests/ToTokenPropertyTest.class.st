"
A ToStyleStampTest is a test class for testing the behavior of ToStyleStamp
"
Class {
	#name : #ToTokenPropertyTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Properties'
}

{ #category : #tests }
ToTokenPropertyTest >> testAsTokenProperty [

	| s |
	s := #color asTokenProperty.
	self assert: s name identicalTo: #color.
	self assert: s value.
	
	s := 'color' asTokenProperty.
	self assert: s name identicalTo: #color.
	self assert: s value.
	
	s := ('color' -> Color red) asTokenProperty.
	self assert: s name identicalTo: #color.
	self assert: s value identicalTo: Color red.
	
	self should: [Object new asTokenProperty] raise: Error
	

]

{ #category : #tests }
ToTokenPropertyTest >> testName [

	| s |
	s := ToTokenProperty new.
	self assert: s name isNil.
	
	s name: #color.
	self assert: s name identicalTo: #color.
	s name: 'color'.
	self assert: s name identicalTo: #color.
	self should: [s name: Object new] raise: Error.
	
	s := ToTokenProperty name: #background value: (BlBackground paint: Color white).
	self assert: s name equals: #background.
	self assert: s value paint color equals: Color white

]

{ #category : #tests }
ToTokenPropertyTest >> testRead [

	| s |
	s := ToTokenProperty new.

	s name: #color.
	s value: [ :e | Color red ].
	self assert: s value isClosure.
	self assert: (s read: nil) identicalTo: Color red.

]

{ #category : #tests }
ToTokenPropertyTest >> testValue [

	| s |
	s := ToTokenProperty new.
	self assert: s value isNil.
	
	s name: #color.
	s value: Color red.
	
	self assert: s value identicalTo: Color red

]
