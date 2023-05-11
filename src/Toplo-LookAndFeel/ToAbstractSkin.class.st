Class {
	#name : #ToAbstractSkin,
	#superclass : #Object,
	#instVars : [
		'theme',
		'tokens'
	],
	#category : #'Toplo-LookAndFeel-Core'
}

{ #category : #testing }
ToAbstractSkin class >> defaultType [

	^ #default
]

{ #category : #testing }
ToAbstractSkin class >> isAbstract [

	^ self = ToAbstractSkin
]

{ #category : #testing }
ToAbstractSkin class >> type [

	^ self defaultType
]

{ #category : #'private - tokens' }
ToAbstractSkin >> buildTokens [

	"Reset previous tokens"
	self tokens: Dictionary new.
		
	self tokens at: #size put: self builtDefaultSize.
]

{ #category : #built }
ToAbstractSkin >> builtDefaultSize [

	^ nil
]

{ #category : #tokens }
ToAbstractSkin >> defaultSize [

	^ self token: #size
]

{ #category : #accessing }
ToAbstractSkin >> initialize [ 

	super initialize.
	self isSupportedByTheme ifTrue:[self buildTokens].
]

{ #category : #testing }
ToAbstractSkin >> isSupportedByTheme [

	^ self isSupportedByTheme: self theme
]

{ #category : #testing }
ToAbstractSkin >> isSupportedByTheme: aTheme [

	^ aTheme class skins includes: self class
]

{ #category : #printing }
ToAbstractSkin >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: ' @ ';
		store: self identityHash
]

{ #category : #accessing }
ToAbstractSkin >> theme [

	^ theme ifNil:[ theme := ToAbstractTheme current ]
]

{ #category : #accessing }
ToAbstractSkin >> theme: anObject [

	theme ~= anObject ifFalse:[ ^ self ].
	theme := anObject.
	self themeChanged.
]

{ #category : #theme }
ToAbstractSkin >> themeChanged [
	"update token dictionary depending theme"
	
	self isSupportedByTheme ifTrue:[ ^ self ].
	self buildTokens. 
]

{ #category : #tokens }
ToAbstractSkin >> token: aSymbol [

	^ self tokens at: aSymbol ifAbsent:[ nil ]
]

{ #category : #tokens }
ToAbstractSkin >> token: aSymbol value: aValue [

	self tokens at: aSymbol put: aValue
]

{ #category : #'private - tokens' }
ToAbstractSkin >> tokens [

	^ tokens ifNil: [ tokens := Dictionary new ]
]

{ #category : #'private - tokens' }
ToAbstractSkin >> tokens: anObject [

	tokens := anObject
]

{ #category : #accessing }
ToAbstractSkin >> type [

	^ self class type
]
