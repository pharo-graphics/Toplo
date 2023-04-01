Class {
	#name : #ToAbstractLabelSkin,
	#superclass : #ToAbstractSkin,
	#category : #'Toplo-LookAndFeel-Skins'
}

{ #category : #testing }
ToAbstractLabelSkin class >> isAbstract [

	^ self = ToAbstractLabelSkin
]

{ #category : #built }
ToAbstractLabelSkin >> buildTokens [

	super buildTokens.
	
	self tokens at: #foreground put: self builtForeground
]

{ #category : #built }
ToAbstractLabelSkin >> builtForeground [

	^ self subclassResponsibility
]

{ #category : #tokens }
ToAbstractLabelSkin >> foreground [

	^ self token: #foreground
]
