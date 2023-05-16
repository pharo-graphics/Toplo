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
	
	self token: #foreground value: self builtForeground.
	self token: #textAttributes value: self builtTextAttributes.
	self token: #foregroundHover value: self builtForegroundHover.
	self token: #textAttributesHover value: self builtTextAttributesHover
]

{ #category : #built }
ToAbstractLabelSkin >> builtForeground [

	^ self subclassResponsibility
]

{ #category : #built }
ToAbstractLabelSkin >> builtForegroundHover [

	^ self builtForeground
]

{ #category : #built }
ToAbstractLabelSkin >> builtTextAttributes [

	^ self subclassResponsibility
]

{ #category : #built }
ToAbstractLabelSkin >> builtTextAttributesHover [

	^ self builtTextAttributes
]

{ #category : #tokens }
ToAbstractLabelSkin >> foreground [

	^ self token: #foreground
]

{ #category : #tokens }
ToAbstractLabelSkin >> foregroundHover [

	^ self token: #foregroundHover
]

{ #category : #tokens }
ToAbstractLabelSkin >> textAttributes [

	^ self token: #textAttributes
]

{ #category : #tokens }
ToAbstractLabelSkin >> textAttributesHover [

	^ self token: #textAttributesHover
]
