Class {
	#name : #ToDataSourceAttachedEvent,
	#superclass : #ToDataSourceAttachementEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToDataSourceAttachedEvent >> sendTo: anObject [

	anObject infiniteElementDataSourceAttachedEvent: self
]
