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
		
	self token: #size value: self builtDefaultSize.
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

	^ aTheme skins includes: self class
]

{ #category : #'events - handling' }
ToAbstractSkin >> onInstalledIn: anElement [
	"This method is a hook. Use this method to inject custom or advanced behavior"
]

{ #category : #'events - handling' }
ToAbstractSkin >> onUninstalledIn: anElement [
	"This method is a hook. Use this method to inject custom or advanced behavior"
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
	
	self isSupportedByTheme ifFalse:[ ^ self ].
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