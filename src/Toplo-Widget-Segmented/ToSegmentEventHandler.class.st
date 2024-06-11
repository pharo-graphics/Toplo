Class {
	#name : #ToSegmentEventHandler,
	#superclass : #ToCheckableEventHandler,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'checkable event handling' }
ToSegmentEventHandler >> checkableCheckEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target holder updateSelection
]

{ #category : #'event handling' }
ToSegmentEventHandler >> clickEvent: anEvent [

	" do nothing here because the selection is managed by the list elemnt "
]

{ #category : #'api - accessing' }
ToSegmentEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { ToCheckableCheckEvent }
]
