Class {
	#name : #ToTreeNodeContainerSkin,
	#superclass : #ToNodeContainerSkin,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'event handling' }
ToTreeNodeContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e arrowButton ifNotNil: [ :arrowButton |
					| wrapper |
					wrapper := e holder dataWrapper.
					wrapper hasLeafDataItem
						ifTrue: [ arrowButton beNone ]
						ifFalse: [
								wrapper isExpanded
									ifFalse: [ arrowButton beRight ]
									ifTrue: [ arrowButton beDown ] ] ] ]
]
