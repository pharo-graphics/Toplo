"
# Style properties (`ToPropertyStyle`)

Style properties define different kind of properties a morphic component can have. There are several types of properties, defined as: 

- `ToContainerStyle`
- `ToDrawStyle`
- `ToFontStyle`
- `ToGeometryStyle`
"
Class {
	#name : #ToPropertyStyle,
	#superclass : #ToStyle,
	#category : #'Toplo-StyleSheet'
}

{ #category : #copying }
ToPropertyStyle >> , other [

	^ self mergeWith: other
]

{ #category : #operations }
ToPropertyStyle >> applyTo: aWidget [
	
]

{ #category : #'instance creation' }
ToPropertyStyle >> fromSton: stonReader [

	"I will use accessors because I want to be able to add convenience methods"
	stonReader parseMapDo: [ :message :value |
		self 
			perform: message asMutator 
			with: (value ifNotNil: [ value asStyleVariable ]) ]
]

{ #category : #testing }
ToPropertyStyle >> isGeometry [

	^ false
]

{ #category : #testing }
ToPropertyStyle >> isStyleProperty [

	^ true
]

{ #category : #operations }
ToPropertyStyle >> mergeWith: otherProperty [
	| merged |

	self species = otherProperty species ifFalse: [ 
		self error: 'Trying to merge two different properties' ].
 
	merged := self species new.
	self class allSlots do: [ :eachSlot | 
		"other property will have precedence over this one"
		merged 
			writeSlot: eachSlot 
			value: ((otherProperty readSlot: eachSlot) ifNil: [ self readSlot: eachSlot ]) ].
		
	^ merged
]

{ #category : #private }
ToPropertyStyle >> toColor: aColorOrSymbol [

	"Try if color"
	aColorOrSymbol isSymbol ifFalse: [ ^ aColorOrSymbol ].
	"Try by name"
	(Color named: aColorOrSymbol) ifNotNil: [ :aColor | ^ aColor ]. 
	"Try by HEX (CSS style)"				
	^ Color fromHexString: aColorOrSymbol
]

{ #category : #private }
ToPropertyStyle >> toVariable: anObject [

	^ anObject ifNotNil: [ anObject asStyleVariable ].
	
]
