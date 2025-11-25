Class {
	#name : #ToTableDividerEventDivider,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #'divider dragging' }
ToTableDividerEventDivider >> dividerDragEvent: anEvent [
]

{ #category : #'divider dragging' }
ToTableDividerEventDivider >> dividerStartDragEvent: anEvent [
]

{ #category : #'api - accessing' }
ToTableDividerEventDivider >> eventsToHandle [

	^ {
		  ToDividerStartDragEvent.
		  ToDividerDragEvent }
]
