Class {
	#name : #ToAbstractLabelSkin,
	#superclass : #ToAbstractSkin,
	#category : #'Toplo-LookAndFeel-Core'
}

{ #category : #testing }
ToAbstractLabelSkin class >> isAbstract [

	^ self = ToAbstractLabelSkin
]

{ #category : #built }
ToAbstractLabelSkin >> buildTokens [

	super buildTokens.
	
	self tokens at: #foreground put: self builtForeground.
	self tokens at: #textAttributes put: self builtTextAttributes
]

{ #category : #built }
ToAbstractLabelSkin >> builtForeground [

	^ self subclassResponsibility
]

{ #category : #built }
ToAbstractLabelSkin >> builtTextAttributes [

	^ self subclassResponsibility
]

{ #category : #tokens }
ToAbstractLabelSkin >> foreground [

	^ self token: #foreground
]

{ #category : #tokens }
ToAbstractLabelSkin >> textAttributes [

	^ self token: #textAttributes
]
