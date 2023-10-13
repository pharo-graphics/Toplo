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

{ #category : #'stamp  private use' }
ToStyleStampTest >> testHasStamp [

	| e |
	e := BlElement new.
	self deny: (e hasStamp: #color).
	e addStyleStamp: (#color -> Color blue) asStyleStamp.
	self assert: (e hasStamp: #color).
	e addStyleStamp: (#background -> Color blue) asStyleStamp.
	e addStyleStamp: (#layout -> BlLinearLayout horizontal) asStyleStamp.
	e addStyleStamp: (#something -> #something) asStyleStamp.
	self assert: (e hasStamp: #something).
	self assert: (e hasStamp: #color).

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

	| e p |
	e := BlElement new.
	e toTheme: ToBeeLightTheme new.
	self
		should: [ e stampNamed: #color ]
		raise: ToElementPropertyNotFound.
	e addStyleStamp: (p := (#color -> Color blue) asStyleStamp).
	self assert: (e stampNamed: #color) equals: p.
	e addStyleStamp: (#background -> Color blue) asStyleStamp.
	e addStyleStamp: (#layout -> BlLinearLayout horizontal) asStyleStamp.
	e addStyleStamp: (p := (#something -> #something) asStyleStamp).
	self assert: (e stampNamed: #something) equals: p.
	self
		should: [ e stampNamed: #Color ]
		raise: ToElementPropertyNotFound
]

{ #category : #'stamp reading' }
ToStyleStampTest >> testStampValue [

	| e p |
	e := BlElement new.
	e toTheme: ToBeeLightTheme new.
	self
		should: [ e stampValue: #color ]
		raise: ToElementPropertyNotFound.
	e addStyleStamp: (p := (#color -> Color blue) asStyleStamp).
	self assert: (e stampValue: #color) equals: p value.
	self assert: (e stampValue: #color) equals: Color blue.
	e addStyleStamp: (#background -> Color blue) asStyleStamp.
	e addStyleStamp: (#layout -> BlLinearLayout horizontal) asStyleStamp.
	e addStyleStamp: ((#something -> #something) asStyleStamp).
	self assert: (e stampValue: #something) equals: #something.
	self
		should: [ e stampValue: #Color ]
		raise: ToElementPropertyNotFound
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

	| e |
	e := BlElement new.
	e withAllStamps: {  }.
	self assert: e localStyleStampIndex isNil.
	e withAllStamps: { #color. #background }.
	self assert: e localStyleStampIndex size equals: 2.
	self assert: (e hasStamp: #color).	
	self assert: (e hasStamp: #background).
	e withAllStamps: { #blob }.
	self assert: e localStyleStampIndex size equals: 3.
	self assert: (e hasStamp: #color).	
	self assert: (e hasStamp: #background).
	self assert: (e hasStamp: #blob).


]

{ #category : #'stamp adding' }
ToStyleStampTest >> testWithStamp [

	| e |
	e := BlElement new.
	e withAllStamps: {  }.
	self assert: e localStyleStampIndex isNil.
	e withStamp: #color.
	e withStamp: #background.
	self assert: e localStyleStampIndex size equals: 2.
	self assert: (e hasStamp: #color).	
	self assert: (e hasStamp: #background).
	self assert: (e stampValue: #color).	
	self assert: (e stampValue: #background).
	e withStamp: #color.
	self assert: e localStyleStampIndex size equals: 2.
	e withStamp: #blob.
	self assert: (e hasStamp: #color).	
	self assert: (e hasStamp: #background).
	self assert: (e hasStamp: #blob).
	self assert: (e stampValue: #color).	
	self assert: (e stampValue: #background).
	self assert: (e stampValue: #blob).


]

{ #category : #'stamp adding' }
ToStyleStampTest >> testWithoutStamp [

	| e |
	e := BlElement new.
	e toTheme: ToBeeLightTheme new.
	e withAllStamps: {  }.
	self assert: e localStyleStampIndex isNil.
	e withStamp: #color.
	e withStamp: #background.
	self assert: e localStyleStampIndex size equals: 2.
	self assert: (e hasStamp: #color).	
	self assert: (e hasStamp: #background).
	self assert: (e stampValue: #color).	
	self assert: (e stampValue: #background).
	e withoutStamp: #color.
	self assert: e localStyleStampIndex size equals: 1.
	e withoutStamp: #blob.
	self deny: (e hasStamp: #color).	
	self assert: (e hasStamp: #background).
	self deny: (e hasStamp: #blob).
	self should: [ e stampValue: #color ] raise: ToElementPropertyNotFound.	
	self assert: (e stampValue: #background).
	self should: [ e stampValue: #blob ] raise: ToElementPropertyNotFound

]
