Class {
	#name : 'ToPlaceholderLayer',
	#superclass : 'BlOverlayElement',
	#category : 'Toplo-Widget-Pane',
	#package : 'Toplo-Widget-Pane'
}

{ #category : 'initialization' }
ToPlaceholderLayer >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : 'initialization' }
ToPlaceholderLayer >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	
]
