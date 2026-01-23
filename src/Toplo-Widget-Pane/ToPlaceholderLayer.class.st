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
ToPlaceholderLayer >> newRawSkin [ 

	^ ToPlaceholderLayerSkin new
]
