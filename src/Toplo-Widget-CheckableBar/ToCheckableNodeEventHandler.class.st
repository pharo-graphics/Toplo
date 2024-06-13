Class {
	#name : #ToCheckableNodeEventHandler,
	#superclass : #ToCheckableEventHandler,
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #'checkable event handling' }
ToCheckableNodeEventHandler >> checkableCheckEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target holder updateSelection
]

{ #category : #'event handling' }
ToCheckableNodeEventHandler >> clickEvent: anEvent [

	" do nothing here because the selection is managed by the list elemnt "
]

{ #category : #'api - accessing' }
ToCheckableNodeEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { ToCheckableCheckEvent }
]
