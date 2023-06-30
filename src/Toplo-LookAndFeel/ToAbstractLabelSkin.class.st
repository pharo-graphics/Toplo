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
	
	"active states"
	self token: #foreground value: self builtForeground.
	self token: #textAttributes value: self builtTextAttributes.
	
	"hover states"
	self token: #foregroundHover value: self builtForegroundHover.
	self token: #textAttributesHover value: self builtTextAttributesHover.
	
	"pressed states"
	self token: #foregroundPressed value: self builtForegroundPressed.
	self token: #textAttributesPressed value: self builtTextAttributesPressed.
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
ToAbstractLabelSkin >> builtForegroundPressed [

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

{ #category : #built }
ToAbstractLabelSkin >> builtTextAttributesPressed [

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
ToAbstractLabelSkin >> foregroundPressed [

	^ self token: #foregroundPressed
]

{ #category : #tokens }
ToAbstractLabelSkin >> textAttributes [

	^ self token: #textAttributes
]

{ #category : #tokens }
ToAbstractLabelSkin >> textAttributesHover [

	^ self token: #textAttributesHover
]

{ #category : #tokens }
ToAbstractLabelSkin >> textAttributesPressed [

	^ self token: #textAttributesPressed
]
