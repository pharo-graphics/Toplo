Class {
	#name : #ToTreeDataItemWrapperCollapsedEvent,
	#superclass : #ToTreeDataItemWrapperEvent,
	#category : #'Toplo-Widget-Tree'
}

{ #category : #sending }
ToTreeDataItemWrapperCollapsedEvent >> sendTo: anObject [

	anObject treeDataItemWrapperCollapsedEvent: self
]
