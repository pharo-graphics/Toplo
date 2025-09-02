Class {
	#name : #ToPlaceholderLayer,
	#superclass : #ToOverlayElement,
	#category : #'Toplo-Widget-Pane-Utils'
}

{ #category : #initialization }
ToPlaceholderLayer >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #initialization }
ToPlaceholderLayer >> initialize [ 

	super initialize.
	self layout: self defaultLayout
	
]

{ #category : #skin }
ToPlaceholderLayer >> installRawStyle [

	super installRawStyle.
	self
		addTokenNamed: #'color-text'
		withValue: (self valueOfTokenNamed: #'color-text-placeholder')
]

{ #category : #skin }
ToPlaceholderLayer >> uninstallRawStyle [

	self removeTokenNamed: #'color-text'.
	super uninstallRawStyle.

]
