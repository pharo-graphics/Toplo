Class {
	#name : #ToStyleSheetTheme,
	#superclass : #ToTheme,
	#instVars : [
		'styleSheet'
	],
	#category : 'Toplo-Core-Skin'
}

{ #category : #initialization }
ToStyleSheetTheme >> defaultElementStyleStampsFor: anElement [ 

	^ { }
]

{ #category : #initialization }
ToStyleSheetTheme >> defaultStampList [
	" skin managing need a list of unique stamps . "

	^ { }
]

{ #category : #accessing }
ToStyleSheetTheme >> name [

	^ #'StyleSheetTheme'
]

{ #category : #accessing }
ToStyleSheetTheme >> newSkinInstaller [

	^ ToStyleSheetSkinInstaller new
]

{ #category : #'writer selecting' }
ToStyleSheetTheme >> rawWritersFor: anElement [

	^ Array streamContents: [ :stream |
		  (self rootRulesFor: anElement) do: [ :r |
			  r putAllWritersFor: anElement in: stream ] ]
]

{ #category : #'writer selecting' }
ToStyleSheetTheme >> rootRulesFor: anElement [

	^ Array streamContents: [ :str |
		  anElement styleSheetChain reverseDo: [ :ss |
			  str nextPutAll: ss styleRules ] ]
]

{ #category : #'writer selecting' }
ToStyleSheetTheme >> skinClassFor: anElement [

	^ ToStyleSheetSkin
]

{ #category : #accessing }
ToStyleSheetTheme >> skinFor: anElement [

	anElement withAllStamps: (self defaultElementStyleStampsFor: anElement).
	^ (self writersFor: anElement)
		  ifEmpty: [(self skinClassFor: anElement) new ]
		  ifNotEmpty: [ :writers |
			  (self skinClassFor: anElement) new
				  writers: writers;
				  yourself ]
]

{ #category : #accessing }
ToStyleSheetTheme >> stampNamed: aSymbol [

	^ self styleSheet stampNamed: aSymbol
]

{ #category : #accessing }
ToStyleSheetTheme >> styleSheet [

	^ styleSheet
]

{ #category : #accessing }
ToStyleSheetTheme >> styleSheet: aStyleSheet [

	aStyleSheet defaultStampList: self defaultStampList.
	styleSheet := aStyleSheet
]

{ #category : #'writer selecting' }
ToStyleSheetTheme >> writersFor: anElement [
	" for an element, several writers can be found. These writers 
	are found with #rawWritersFor:. After, for each property only the last writers is kept"

	| rawWriters supplement uniqueWriters eventClassIndex |
	
	" get all subscriptions for anElement "
	rawWriters := self rawWritersFor: anElement.
	
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
	
	^ Array streamContents: [:str | 
			str nextPutAll: (uniqueWriters sort: [ :a :b | a property name < b property name ]).
	  		str nextPutAll: supplement ]
]
