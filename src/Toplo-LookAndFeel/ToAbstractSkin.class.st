Class {
	#name : #ToAbstractSkin,
	#superclass : #Object,
	#instVars : [
		'theme',
		'tokens'
	],
	#category : #'Toplo-LookAndFeel-Skins'
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
]

{ #category : #accessing }
ToAbstractSkin >> initialize [ 

	super initialize.
	self buildTokens.
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
