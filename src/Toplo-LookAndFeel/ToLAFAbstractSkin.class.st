Class {
	#name : #ToLAFAbstractSkin,
	#superclass : #Object,
	#instVars : [
		'theme',
		'tokens'
	],
	#category : #'Toplo-LookAndFeel-Core'
}

{ #category : #testing }
ToLAFAbstractSkin class >> defaultType [

	^ #default
]

{ #category : #testing }
ToLAFAbstractSkin class >> isAbstract [

	^ self = ToLAFAbstractSkin
]

{ #category : #testing }
ToLAFAbstractSkin class >> type [

	^ self defaultType
]

{ #category : #'private - tokens' }
ToLAFAbstractSkin >> buildTokens [

	"Reset previous tokens"
	self tokens: Dictionary new.
		
	self token: #size value: self builtDefaultSize.
]

{ #category : #built }
ToLAFAbstractSkin >> builtDefaultSize [

	^ nil
]

{ #category : #tokens }
ToLAFAbstractSkin >> defaultSize [

	^ self token: #size
]

{ #category : #accessing }
ToLAFAbstractSkin >> initialize [ 

	super initialize.
	self isSupportedByTheme ifTrue:[self buildTokens].
]

{ #category : #testing }
ToLAFAbstractSkin >> isSupportedByTheme [

	^ self isSupportedByTheme: self theme
]

{ #category : #testing }
ToLAFAbstractSkin >> isSupportedByTheme: aTheme [

	^ aTheme skins includes: self class
]

{ #category : #'events - handling' }
ToLAFAbstractSkin >> onInstalledIn: anElement [
	"This method is a hook. Use this method to inject custom or advanced behavior"
]

{ #category : #'events - handling' }
ToLAFAbstractSkin >> onUninstalledIn: anElement [
	"This method is a hook. Use this method to inject custom or advanced behavior"
]

{ #category : #printing }
ToLAFAbstractSkin >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: ' @ ';
		store: self identityHash
]

{ #category : #accessing }
ToLAFAbstractSkin >> theme [

	^ theme ifNil:[ theme := ToAbstractTheme current ]
]

{ #category : #accessing }
ToLAFAbstractSkin >> theme: anObject [

	theme ~= anObject ifFalse:[ ^ self ].
	theme := anObject.
	self themeChanged.
]

{ #category : #theme }
ToLAFAbstractSkin >> themeChanged [
	"update token dictionary depending theme"
	
	self isSupportedByTheme ifFalse:[ ^ self ].
	self buildTokens. 
]

{ #category : #tokens }
ToLAFAbstractSkin >> token: aSymbol [

	^ self tokens at: aSymbol ifAbsent:[ nil ]
]

{ #category : #tokens }
ToLAFAbstractSkin >> token: aSymbol value: aValue [

	self tokens at: aSymbol put: aValue
]

{ #category : #'private - tokens' }
ToLAFAbstractSkin >> tokens [

	^ tokens ifNil: [ tokens := Dictionary new ]
]

{ #category : #'private - tokens' }
ToLAFAbstractSkin >> tokens: anObject [

	tokens := anObject
]

{ #category : #accessing }
ToLAFAbstractSkin >> type [

	^ self class type
]
