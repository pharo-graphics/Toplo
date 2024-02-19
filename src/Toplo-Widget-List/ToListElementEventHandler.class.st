Class {
	#name : #ToListElementEventHandler,
	#superclass : #ToBasicListElementEventHandler,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'infinite event handling' }
ToListElementEventHandler >> collectionEmptinessEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToCollectionEmptinessEvent }
]
