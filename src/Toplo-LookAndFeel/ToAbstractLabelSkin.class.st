Class {
	#name : #ToAbstractLabelSkin,
	#superclass : #ToAbstractSkin,
	#category : #'Toplo-LookAndFeel-Skins - Labels'
}

{ #category : #testing }
ToAbstractLabelSkin class >> isAbstract [

	^ self = ToAbstractLabelSkin
]

{ #category : #built }
ToAbstractLabelSkin >> background [

	^ self tokens at: #background
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
