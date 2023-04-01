Class {
	#name : #ToAbstractLabelSkin,
	#superclass : #ToAbstractSkin,
	#category : #'Toplo-LookAndFeel-Skins'
}

{ #category : #testing }
ToAbstractLabelSkin class >> isAbstract [

	^ self = ToAbstractLabelSkin
]

{ #category : #tokens }
ToAbstractLabelSkin >> background [

	^ self token: #background
]

{ #category : #tokens }
ToAbstractLabelSkin >> border [

	^ self token: #border
]

{ #category : #built }
ToAbstractLabelSkin >> buildTokens [

	super buildTokens.
	
	self tokens at: #background put: self builtBackground
]

{ #category : #built }
ToAbstractLabelSkin >> builtBackground [ 

	^ self subclassResponsibility
]
