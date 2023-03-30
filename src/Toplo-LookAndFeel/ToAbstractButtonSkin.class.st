Class {
	#name : #ToAbstractButtonSkin,
	#superclass : #ToAbstractSkin,
	#category : #'Toplo-LookAndFeel-Skins'
}

{ #category : #testing }
ToAbstractButtonSkin class >> isAbstract [

	^ self = ToAbstractButtonSkin
]

{ #category : #accessing }
ToAbstractButtonSkin >> background [

	^ self tokens at: #background
]

{ #category : #accessing }
ToAbstractButtonSkin >> buildTokens [

	super buildTokens.
	
	self tokens at: #background put: self builtBackground.
]

{ #category : #accessing }
ToAbstractButtonSkin >> builtBackground [ 

	^ self subclassResponsibility 
]
