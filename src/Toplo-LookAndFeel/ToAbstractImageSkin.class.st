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
	
	"active"
	self token: #foreground value: self builtForeground.
	
	"hover"
	self token: #foregroundHover value: self builtForegroundHover.
	
	"pressed"
	self token: #foregroundPressed value: self builtForegroundPressed.
]

{ #category : #built }
ToAbstractImageSkin >> builtForeground [

	^ self subclassResponsibility
]

{ #category : #built }
ToAbstractImageSkin >> builtForegroundHover [

	^ self builtForeground
]

{ #category : #built }
ToAbstractImageSkin >> builtForegroundPressed [

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

{ #category : #tokens }
ToAbstractImageSkin >> foregroundPressed [

	^ self token: #foregroundPressed
]
