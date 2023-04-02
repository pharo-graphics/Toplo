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

{ #category : #tokens }
ToAbstractSkin >> buildTokens [

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
	self buildTokens.
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
	
	self buildTokens. 
]

{ #category : #tokens }
ToAbstractSkin >> token: aSymbol [

	^ self tokens at: aSymbol ifAbsent:[ nil ]
]

{ #category : #tokens }
ToAbstractSkin >> tokens [

	^ tokens ifNil: [ tokens := Dictionary new ]
]

{ #category : #tokens }
ToAbstractSkin >> tokens: anObject [

	tokens := anObject
]

{ #category : #accessing }
ToAbstractSkin >> type [

	^ self class type
]
