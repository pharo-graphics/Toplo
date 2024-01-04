Class {
	#name : #ToInfiniteSelectionDirtyEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToInfiniteSelectionDirtyEvent >> sendTo: anObject [

	anObject infiniteSelectionDirtyEvent: self
]
