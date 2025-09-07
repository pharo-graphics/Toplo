Class {
	#name : #ToAllLinkActionsRunnedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #sending }
ToAllLinkActionsRunnedEvent >> sendTo: anObject [

	anObject allLinkActionsRunnedEvent: self
]
