Class {
	#name : #ToStyleSheetTheme,
	#superclass : #ToTheme,
	#traits : 'TToStyleRuleScripter + TToStyleRulesHolder',
	#classTraits : 'TToStyleRuleScripter classTrait + TToStyleRulesHolder classTrait',
	#instVars : [
		'styleSheet'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #testing }
ToStyleSheetTheme class >> canBeDefault [

	^ false
]

{ #category : #visiting }
ToStyleSheetTheme >> accept: aVisitor [

	aVisitor visitStyleSheetTheme: self.
]

{ #category : #styling }
ToStyleSheetTheme >> applicableListenersFor: anElement [
	" for an element, several listeners can be found (actions and writers). These listeners 
	are found with #unsortedApplicableListenersFor:. 
	After, the result collection contains :
	- all actions 
	- for each property only the last writer 
	- and then all supplements.
	"

	| unsortedListeners supplement uniqueListeners eventClassIndex lookEventActions |
	anElement isAttachedToSceneGraph ifFalse: [ ^ #(  ) ].

	" get all subscriptions for anElement "
	unsortedListeners := self unsortedApplicableListenersFor: anElement.

	" keep only the last writers for each property except those which are declared as supplement"
	eventClassIndex := IdentityDictionary new.
	supplement := OrderedCollection new.
	lookEventActions := OrderedCollection new.

	" first build a 2 level index : the first level key is the eventClass, the second level key is the property "
	unsortedListeners do: [ :w |
		w isSupplement
			ifTrue: [ supplement add: w ]
			ifFalse: [
				| indexByProperty |
				indexByProperty := eventClassIndex
					                   at: w eventClass
					                   ifAbsentPut: [ OrderPreservingIdentityDictionary new ].
				indexByProperty at: w property put: w ] ].

	uniqueListeners := Array streamContents: [ :str |
		                   eventClassIndex valuesDo: [ :indexByProperty | " actions property is the ToNullProperty uniqueInstance "
			                   indexByProperty
				                   at: ToNullProperty uniqueInstance
				                   ifPresent: [ :listener |
				                   lookEventActions add: listener ].

			                   indexByProperty
				                   removeKey: ToNullProperty uniqueInstance
				                   ifAbsent: [  ].

			                   " add all other listeners - these are all property writers "
			                   str nextPutAll: indexByProperty values ] ].

	^ Array streamContents: [ :str |
		  str nextPutAll: lookEventActions.
		  str nextPutAll: uniqueListeners.
		  str nextPutAll: supplement ]
]

{ #category : #'css like printing' }
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

{ #category : #styling }
ToStyleSheetTheme >> applicableWritersFor: anElement [
	" for an element, several writers can be found. These writers 
	are found with #rawWritersFor:. After, for each property only the last writers is kept"

	^ (self applicableListenersFor: anElement) select: [ :l |
		  l isPropertyWriter ]
]

{ #category : #initialization }
ToStyleSheetTheme >> defaultElementStampsFor: anElement [ 

	^ { }
]

{ #category : #initialization }
ToStyleSheetTheme >> initialize [ 

	super initialize.
	styleSheet := ToStyleSheet new.
	self initializeStyleRules
]

{ #category : #initialization }
ToStyleSheetTheme >> initializeStyleRules [
]

{ #category : #'t - stylesheet scripter' }
ToStyleSheetTheme >> lookEventListenerHolder [ 

	^ self styleSheet script
]

{ #category : #accessing }
ToStyleSheetTheme >> newSkinInstanceFor: anElement [

	| skin |
	skin := (self skinClassFor: anElement) new.
	(self applicableListenersFor: anElement) ifNotEmpty: [ :writers |
		skin lookEventListeners: writers ].
	^ skin
]

{ #category : #'api - hooks' }
ToStyleSheetTheme >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement styleSheet: self styleSheet
]

{ #category : #'api - hooks' }
ToStyleSheetTheme >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement styleSheet: nil
]

{ #category : #'accessing - writable properties' }
ToStyleSheetTheme >> property: aSymbol [

	^ self styleSheet writablePropertyNamed: aSymbol
]

{ #category : #accessing }
ToStyleSheetTheme >> rawStyleRules [

	^ self styleSheet styleRules
]

{ #category : #accessing }
ToStyleSheetTheme >> rawStyleRules: aStyleRuleCollection [

	self styleSheet script styleRules: aStyleRuleCollection
]

{ #category : #styling }
ToStyleSheetTheme >> rootRulesFor: anElement [

	^ Array streamContents: [ :str |
		  anElement styleSheetChain reverseDo: [ :ss |
			  str nextPutAll: ss styleRules ] ]
]

{ #category : #hook }
ToStyleSheetTheme >> setUpElement: anElement [

	super setUpElement: anElement.
	anElement addAllStamps: (self defaultElementStampsFor: anElement) 
]

{ #category : #styling }
ToStyleSheetTheme >> skinClassFor: anElement [

	^ ToStyleSheetSkin
]

{ #category : #accessing }
ToStyleSheetTheme >> styleSheet [

	^ styleSheet
]

{ #category : #styling }
ToStyleSheetTheme >> unsortedApplicableListenersFor: anElement [

	^ Array streamContents: [ :stream |
		  (self rootRulesFor: anElement) do: [ :r |
			  r putApplicableListenersForElement: anElement forTheme: self in: stream ] ]
]
