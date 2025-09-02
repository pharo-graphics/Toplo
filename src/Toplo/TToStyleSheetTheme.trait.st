Trait {
	#name : #TToStyleSheetTheme,
	#instVars : [
		'styleSheet'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #'t - style sheet theme - accessing writable properties' }
TToStyleSheetTheme >> addWritableProperty: aProperty [

	self styleSheet addWritableProperty: aProperty
]

{ #category : #'t - style sheet theme - styling' }
TToStyleSheetTheme >> applicableListenersFor: anElement [
	" for an element, several listeners can be found (actions and writers). These listeners 
	are found with #unsortedApplicableListenersFor:. 
	After, the result collection contains :
	- all actions 
	- for each property only the last writer 
	- and then all supplements.
	"

	| unsortedListeners supplement uniqueListeners eventClassIndex actions |
	anElement isAttachedToSceneGraph ifFalse: [ ^ #(  ) ].

	" get all subscriptions for anElement "
	unsortedListeners := self unsortedApplicableListenersFor: anElement.

	" keep only the last writers for each property except those which are declared as supplement"
	eventClassIndex := IdentityDictionary new.
	supplement := OrderedCollection new.
	actions := OrderedCollection new.

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
				                   actions add: listener ].

			                   indexByProperty
				                   removeKey: ToNullProperty uniqueInstance
				                   ifAbsent: [  ].

			                   " add all other listeners - these are all property writers "
			                   str nextPutAll: indexByProperty values ] ].

	^ Array streamContents: [ :str |
		  str nextPutAll: actions.
		  str nextPutAll: uniqueListeners.
		  str nextPutAll: supplement ]
]

{ #category : #'t - style sheet theme - styling' }
TToStyleSheetTheme >> applicableRulesFor: anElement [
	" return applicable rules for an element "

	| rootRules |
	anElement isAttachedToSceneGraph ifFalse: [ ^ #(  ) ].
	" get all subscriptions for anElement "
	rootRules := self rootRulesFor: anElement.
	^ Array streamContents: [:str | 
		rootRules do:[ :r | (r copyWithOnlyApplicableRuleFor: anElement inTheme: self) 
			ifNotNil:[ :anApplicableRule | str nextPut: anApplicableRule ] ] ]
]

{ #category : #'t - style sheet theme - styling' }
TToStyleSheetTheme >> applicableWritersFor: anElement [
	" for an element, several writers can be found. These writers 
	are found with #rawWritersFor:. After, for each property only the last writers is kept"

	^ (self applicableListenersFor: anElement) select: [ :l |
		  l isPropertyWriter ]
]

{ #category : #'t - style sheet theme' }
TToStyleSheetTheme >> initializeAsStyleSheetTheme [

	styleSheet := ToStyleSheet new.
	self initializeStyleRules
]

{ #category : #'t - style sheet theme' }
TToStyleSheetTheme >> initializeStyleRules [
]

{ #category : #'t - style sheet theme - accessing writable properties' }
TToStyleSheetTheme >> property: aSymbol [

	^ self styleSheet writablePropertyNamed: aSymbol
]

{ #category : #'t - style sheet theme' }
TToStyleSheetTheme >> rawStyleRules [

	^ self styleSheet styleRules
]

{ #category : #'t - style sheet theme' }
TToStyleSheetTheme >> rawStyleRules: aStyleRuleCollection [

	self styleSheet script styleRules: aStyleRuleCollection
]

{ #category : #'t - style sheet theme - styling' }
TToStyleSheetTheme >> rootRulesFor: anElement [

	^ Array streamContents: [ :str |
		  anElement styleSheetChain reverseDo: [ :ss |
			  str nextPutAll: ss styleRules ] ]
]

{ #category : #'t - style sheet theme' }
TToStyleSheetTheme >> styleSheet [ 

	^ styleSheet
]

{ #category : #'t - style sheet theme - styling' }
TToStyleSheetTheme >> unsortedApplicableListenersFor: anElement [

	^ Array streamContents: [ :stream |
		  (self rootRulesFor: anElement) do: [ :r |
			  r putApplicableListenersForElement: anElement forTheme: self in: stream ] ]
]
