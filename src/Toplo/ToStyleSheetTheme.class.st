Class {
	#name : 'ToStyleSheetTheme',
	#superclass : 'ToTheme',
	#traits : 'TToStyleRuleScripter',
	#classTraits : 'TToStyleRuleScripter classTrait',
	#instVars : [
		'styleSheet'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'testing' }
ToStyleSheetTheme class >> canBeDefault [

	^ false
]

{ #category : 'css like printing' }
ToStyleSheetTheme >> applicableRulesFor: anElement [
	" return applicable rules for an element "

	| rootRules |
	anElement isAttachedToSceneGraph ifFalse: [ ^ #(  ) ].
	" get all subscriptions for anElement "
	rootRules := self rootRulesFor: anElement.
	^ Array streamContents: [:str | 
		rootRules do:[ :r | (r copyWithOnlyApplicableRuleFor: anElement inTheme: self) 
			ifNotNil:[ :anApplicableRule | str nextPut: anApplicableRule ] ] ]
]

{ #category : 'styling' }
ToStyleSheetTheme >> applicableWritersFor: anElement [
	" for an element, several writers can be found. These writers 
	are found with #rawWritersFor:. After, for each property only the last writers is kept"

	| rawWriters supplement uniqueWriters eventClassIndex |
	anElement isAttachedToSceneGraph ifFalse: [ ^ #(  ) ].

	" get all subscriptions for anElement "
	rawWriters := self rawApplicableWritersFor: anElement.

	" keep only the last writers for each property except those which are declared as supplement"
	eventClassIndex := IdentityDictionary new.
	supplement := OrderedCollection new.

	rawWriters do: [ :w |
		w supplement
			ifTrue: [ supplement add: w ]
			ifFalse: [
				| indexByProperty |
				indexByProperty := eventClassIndex
					                   at: w eventClass
					                   ifAbsentPut: [ IdentityDictionary new ].
				indexByProperty at: w property put: w ] ].

	uniqueWriters := Array streamContents: [ :str |
		                 eventClassIndex valuesDo: [ :indexByProperty |
			                 str nextPutAll: indexByProperty values ] ].

	^ Array streamContents: [ :str |
		  str nextPutAll:
			  (uniqueWriters sort: [ :a :b | a property name < b property name ]).
		  str nextPutAll: supplement ]
]

{ #category : 'initialization' }
ToStyleSheetTheme >> defaultElementStampsFor: anElement [ 

	^ { }
]

{ #category : 'initialization' }
ToStyleSheetTheme >> initialize [ 

	super initialize.
	styleSheet := ToStyleSheet new.
	self initializeStyleRules
]

{ #category : 'initialization' }
ToStyleSheetTheme >> initializeStyleRules [
]

{ #category : 'accessing' }
ToStyleSheetTheme >> newSkinInstanceFor: anElement [

	| skin |
	skin := (self skinClassFor: anElement) new.
	(self applicableWritersFor: anElement) ifNotEmpty: [ :writers |
		skin propertyWriters: writers ].
	^ skin
]

{ #category : 'accessing - writable properties' }
ToStyleSheetTheme >> property: aSymbol [

	^ self styleSheet writablePropertyNamed: aSymbol
]

{ #category : 't - stylesheet scripter' }
ToStyleSheetTheme >> propertyWritersHolder [ 

	^ self styleSheet script
]

{ #category : 'styling' }
ToStyleSheetTheme >> rawApplicableWritersFor: anElement [

	^ Array streamContents: [ :stream |
		  (self rootRulesFor: anElement) do: [ :r |
			  r putApplicableWritersForElement: anElement forTheme: self in: stream ] ]
]

{ #category : 'styling' }
ToStyleSheetTheme >> rootRulesFor: anElement [

	^ Array streamContents: [ :str |
		  anElement styleSheetChain reverseDo: [ :ss |
			  str nextPutAll: ss styleRules ] ]
]

{ #category : 'hook' }
ToStyleSheetTheme >> setUpElement: anElement [

	super setUpElement: anElement.
	anElement addAllStamps: (self defaultElementStampsFor: anElement) 
]

{ #category : 'styling' }
ToStyleSheetTheme >> skinClassFor: anElement [

	^ ToStyleSheetSkin
]

{ #category : 'accessing' }
ToStyleSheetTheme >> styleSheet [

	^ styleSheet
]
