Class {
	#name : #ToTreeDataItemWrapperCollapsedEvent,
	#superclass : #ToTreeDataItemWrapperEvent,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #sending }
ToTreeDataItemWrapperCollapsedEvent >> sendTo: anObject [

	anObject treeDataItemWrapperCollapsedEvent: self
]
