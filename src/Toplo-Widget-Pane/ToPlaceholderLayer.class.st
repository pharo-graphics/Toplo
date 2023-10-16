Class {
	#name : 'ToPlaceholderLayer',
	#superclass : 'BlOverlayElement',
	#category : 'Toplo-Widget-Pane',
	#package : 'Toplo-Widget-Pane'
}

{ #category : 'initialization' }
ToPlaceholderLayer >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : 'initialization' }
ToPlaceholderLayer >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	
]
