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
ToAbstractSkin class >> isAbstract [

	^ self = ToAbstractSkin
]

{ #category : #private }
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

	^ theme ifNil:[ theme := ToTheme default ]
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

{ #category : #accessing }
ToAbstractSkin >> tokens [

	^ tokens ifNil: [ tokens := Dictionary new ]
]

{ #category : #accessing }
ToAbstractSkin >> tokens: anObject [

	tokens := anObject
]
