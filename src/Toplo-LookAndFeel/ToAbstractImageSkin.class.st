Class {
	#name : #ToAbstractImageSkin,
	#superclass : #ToAbstractSkin,
	#category : #'Toplo-LookAndFeel-Core'
}

{ #category : #testing }
ToAbstractImageSkin class >> isAbstract [

	^ self == ToAbstractImageSkin
]

{ #category : #built }
ToAbstractImageSkin >> buildTokens [

	super buildTokens.
	
	self token: #foreground value: self builtForeground.
	self token: #foregroundHover value: self builtForegroundHover
]

{ #category : #built }
ToAbstractImageSkin >> builtForeground [

	^ self subclassResponsibility
]

{ #category : #built }
ToAbstractImageSkin >> builtForegroundHover [

	^ self builtForeground
]

{ #category : #tokens }
ToAbstractImageSkin >> foreground [

	^ self token: #foreground
]

{ #category : #tokens }
ToAbstractImageSkin >> foregroundHover [

	^ self token: #foregroundHover
]
