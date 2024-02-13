Class {
	#name : #ToDataSourceDetachedEvent,
	#superclass : #ToDataSourceAttachementEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToDataSourceDetachedEvent >> sendTo: anObject [

	anObject infiniteElementDataSourceDetachedEvent: self
]
