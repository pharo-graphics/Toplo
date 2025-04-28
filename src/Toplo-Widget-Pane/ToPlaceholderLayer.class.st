Class {
	#name : #ToPlaceholderLayer,
	#superclass : #ToOverlayElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#category : #'Toplo-Widget-Pane-Utils'
}

{ #category : #initialization }
ToPlaceholderLayer >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #initialization }
ToPlaceholderLayer >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self initializeForToplo 

	
]

{ #category : #skin }
ToPlaceholderLayer >> installRawStyle [ 

	super installRawStyle.
	self addTokenNamed: #'color-text' withValue: Color veryLightGray 
]

{ #category : #skin }
ToPlaceholderLayer >> uninstallRawStyle [ 

	super uninstallRawStyle.
	self removeTokenNamed: #'color-text'
]
