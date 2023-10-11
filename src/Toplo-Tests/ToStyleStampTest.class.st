"
A ToStyleStampTest is a test class for testing the behavior of ToStyleStamp
"
Class {
	#name : #ToStyleStampTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Properties'
}

{ #category : #'stamp  private use' }
ToStyleStampTest >> testAddStyleStamp [

	| e s s2 |
	e := BlElement new.
	e addStyleStamp: (#color -> Color blue) asStyleStamp.
	self assert: (s := e localStyleStampNamed: #color) notNil.
	self assert: (s isKindOf: ToStyleStamp).
	self assert: s name equals: #color.
	self assert: s value equals: Color blue.
	self assert: e localStyleStampIndex size equals: 1.
	e addStyleStamp: (#color -> Color red) asStyleStamp.
	self assert: (s2 := e localStyleStampNamed: #color) notNil.
	self assert: s2 name equals: #color.
	self assert: s2 value equals: Color red.
	self assert: s ~~ s2.
	self assert: e localStyleStampIndex size equals: 1
]

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

{ #category : #'stamp reading' }
ToStyleStampTest >> testHasStamp [
]

{ #category : #'stamp  private use' }
ToStyleStampTest >> testLocalStyleStampIndex [

	| e dict |
	e := BlElement new.
	dict := e localStyleStampIndex.
	self assert: dict isNil.
	
	e ensureLocalStyleStampIndex.
	dict := e localStyleStampIndex.
	self assert: dict notNil.
	self assert: (e userData includesKey: #localStyleStampIndex)
]

{ #category : #'stamp  private use' }
ToStyleStampTest >> testLocalStyleStampNamed [

	| e s |
	e := BlElement new.
	e ensureLocalStyleStampIndex.
	self assert: (e localStyleStampNamed: #color) isNil.
	(e userData at: #localStyleStampIndex)
		addProperty: #color asStyleStamp.
	s := e localStyleStampNamed: #color.
	self assert: s notNil.
	self assert: (s isKindOf: ToStyleStamp).
	self assert: s name equals: #color.
	self assert: s value
]

{ #category : #'stamp  private use' }
ToStyleStampTest >> testLookUpStyleStampNamed [

	| e child |
	e := BlElement new.
	child := BlElement new.
	e addStyleStamp: (#color -> Color blue) asStyleStamp.
	self assert: e localStyleStampIndex size equals: 1.
	self
		assert: (e lookUpStyleStampNamed: #color)
		identicalTo: (e localStyleStampNamed: #color).
	e addChild: child.
	self
		assert: (child lookUpStyleStampNamed: #color)
		identicalTo: (e localStyleStampNamed: #color).
	child addStyleStamp: (#color -> Color red) asStyleStamp.
	self
		assert: (child lookUpStyleStampNamed: #color)
		identicalTo: (child localStyleStampNamed: #color)
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

{ #category : #'stamp  private use' }
ToStyleStampTest >> testRemoveStyleStamp [

	| e |
	e := BlElement new.
	e addStyleStamp: (#color -> Color blue) asStyleStamp.
	self assert: e localStyleStampIndex size equals: 1.
	e removeStyleStamp: #color asStyleStamp.
	self assert: e localStyleStampIndex isEmpty.
	e removeStyleStamp: #color asStyleStamp.
	self assert: e localStyleStampIndex isEmpty
]

{ #category : #'stamp  private use' }
ToStyleStampTest >> testRemoveStyleStampNamed [

	| e |
	e := BlElement new.
	e addStyleStamp: (#color -> Color blue) asStyleStamp.
	self assert: e localStyleStampIndex size equals: 1.
	e removeStyleStampNamed: #color.
	self assert: e localStyleStampIndex isEmpty.
	self should: [ e removeStyleStampNamed: #color ] raise: ToElementPropertyNotFound.
	self assert: e localStyleStampIndex isEmpty
]

{ #category : #'stamp  private use' }
ToStyleStampTest >> testRemoveStyleStampNamedIfAbsent [

	| e |
	e := BlElement new.
	e addStyleStamp: (#color -> Color blue) asStyleStamp.
	self assert: e localStyleStampIndex size equals: 1.
	e removeStyleStampNamed: #color.
	self assert: e localStyleStampIndex isEmpty.
	self should: [ e removeStyleStampNamed: #color ] raise: ToElementPropertyNotFound.
	e addStyleStamp: (#color -> Color red) asStyleStamp.
	self assert: e localStyleStampIndex size equals: 1.
	e removeStyleStampNamed: #blob ifAbsent: [  ].
	self assert: e localStyleStampIndex size equals: 1.
	e removeStyleStampNamed: ##color ifAbsent: [  ].
	self assert: e localStyleStampIndex isEmpty.


]

{ #category : #'stamp reading' }
ToStyleStampTest >> testStampNamed [
]

{ #category : #'stamp reading' }
ToStyleStampTest >> testStampValue [
]

{ #category : #tests }
ToStyleStampTest >> testValue [

	| s |
	s := ToStyleStamp new.
	self assert: s value isNil.
	
	s name: #color.
	s value: Color red.
	
	self assert: s value identicalTo: Color red.
	s value: [ Color red ].
	self assert: s value isClosure.

]

{ #category : #'stamp adding' }
ToStyleStampTest >> testWithAllStamps [
]

{ #category : #'stamp adding' }
ToStyleStampTest >> testWithStamp [


]

{ #category : #'stamp adding' }
ToStyleStampTest >> testWithoutStamp [
]
